import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_project/models/api_requests.dart';
import 'package:flutter_project/views/custom_widgets/forms_button_style.dart';
import 'dart:math' as math;
import 'package:flutter_project/views/custom_widgets/theme.dart';
import 'package:flutter_project/views/size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SymptomScreen extends StatefulWidget {
  const SymptomScreen({super.key});

  @override
  State<SymptomScreen> createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  diagnose() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> jsonconverter = {'diseases': mapSymptoms};
    String jsonString = jsonEncode(jsonconverter);
    log(jsonString);
    try {
      http.Response res = await http.post(
          Uri.parse(
            '$baseUrl/patients/disease-prediction',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonString);
      log(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        setState(() {
          isLoading = false;
        });
        Map<String, dynamic> data = jsonDecode(res.body)['result'];
        diagnosis = data['results'] as String;
        log(diagnosis.toString());
        if (diagnosis != null && diagnosis!.isNotEmpty) {
          Alert(
            context: context,
            title: 'You might have ${diagnosis}',
            desc: "Please check your doctor",
            buttons: [
              DialogButton(
                onPressed: () => Navigator.pop(context),
                color: const Color.fromRGBO(0, 179, 134, 1.0),
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ).show();
        }
      }
     
    } on Exception catch (e) {
      log('failed');
      log(e.toString());
    }
  }

  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  bool tapped = false;
  String? diagnosis;
  FocusNode _focusNode = FocusNode();
  List<String> searchedForItems = [];
  List<String> choosenItems = [];
  List<String> symbtoms = [
    'itching',
    'skin_rash',
    'nodal_skin_eruptions',
    'continuous_sneezing',
    'shivering',
    'chills',
    'joint_pain',
    'stomach_pain',
    'acidity',
    'ulcers_on_tongue',
    'muscle_wasting',
    'vomiting',
    'burning_micturition',
    'spotting_ urination',
    'fatigue',
    'weight_gain',
    'anxiety',
    'cold_hands_and_feets',
    'mood_swings',
    'weight_loss',
    'restlessness',
    'lethargy',
    'patches_in_throat',
    'irregular_sugar_level',
    'cough',
    'high_fever',
    'sunken_eyes',
    'breathlessness',
    'sweating',
    'dehydration',
    'indigestion',
    'headache',
    'yellowish_skin',
    'dark_urine',
    'nausea',
    'loss_of_appetite',
    'pain_behind_the_eyes',
    'back_pain',
    'constipation',
    'abdominal_pain',
    'diarrhoea',
    'mild_fever',
    'yellow_urine',
    'yellowing_of_eyes',
    'acute_liver_failure',
    'fluid_overload',
    'swelling_of_stomach',
    'swelled_lymph_nodes',
    'malaise',
    'blurred_and_distorted_vision',
    'phlegm',
    'throat_irritation',
    'redness_of_eyes',
    'sinus_pressure',
    'runny_nose',
    'congestion',
    'chest_pain',
    'weakness_in_limbs',
    'fast_heart_rate',
    'pain_during_bowel_movements',
    'pain_in_anal_region',
    'bloody_stool',
    'irritation_in_anus',
    'neck_pain',
    'dizziness',
    'cramps',
    'bruising',
    'obesity',
    'swollen_legs',
    'swollen_blood_vessels',
    'puffy_face_and_eyes',
    'enlarged_thyroid',
    'brittle_nails',
    'swollen_extremeties',
    'excessive_hunger',
    'extra_marital_contacts',
    'drying_and_tingling_lips',
    'slurred_speech',
    'knee_pain',
    'hip_joint_pain',
    'muscle_weakness',
    'stiff_neck',
    'swelling_joints',
    'movement_stiffness',
    'spinning_movements',
    'loss_of_balance',
    'unsteadiness',
    'weakness_of_one_body_side',
    'loss_of_smell',
    'bladder_discomfort',
    'foul_smell_of urine',
    'continuous_feel_of_urine',
    'passage_of_gases',
    'internal_itching',
    'toxic_look_(typhos)',
    'depression',
    'irritability',
    'muscle_pain',
    'altered_sensorium',
    'red_spots_over_body',
    'belly_pain',
    'abnormal_menstruation',
    'dischromic _patches',
    'watering_from_eyes',
    'increased_appetite',
    'polyuria',
    'family_history',
    'mucoid_sputum',
    'rusty_sputum',
    'lack_of_concentration',
    'visual_disturbances',
    'receiving_blood_transfusion',
    'receiving_unsterile_injections',
    'coma',
    'stomach_bleeding',
    'distention_of_abdomen',
    'history_of_alcohol_consumption',
    'fluid_overload.1',
    'blood_in_sputum',
    'prominent_veins_on_calf',
    'palpitations',
    'painful_walking',
    'pus_filled_pimples',
    'blackheads',
    'scurring',
    'skin_peeling',
    'silver_like_dusting',
    'small_dents_in_nails',
    'inflammatory_nails',
    'blister',
    'red_sore_around_nose',
    'yellow_crust_ooze',
  ];
  search() {
    searchedForItems = symbtoms
        .where((element) => element.startsWith(controller.text))
        .toList();
    setState(() {});
  }

  bodyChoose(String key) {
    searchedForItems.clear();
    organsSymptoms[key]!.forEach((element) {
      setState(() {
        tapped = true;
      });
      searchedForItems.add(element);
      // log(element);
    });
    setState(() {});
  }

  Map<String, int> mapSymptoms = {
    "itching": 0,
    "skin_rash": 0,
    "nodal_skin_eruptions": 0,
    "continuous_sneezing": 0,
    "shivering": 0,
    "chills": 0,
    "joint_pain": 0,
    "stomach_pain": 0,
    "acidity": 0,
    "ulcers_on_tongue": 0,
    "muscle_wasting": 0,
    "vomiting": 0,
    "burning_micturition": 0,
    "spotting_ urination": 0,
    "fatigue": 0,
    "weight_gain": 0,
    "anxiety": 0,
    "cold_hands_and_feets": 0,
    "mood_swings": 0,
    "weight_loss": 0,
    "restlessness": 0,
    "lethargy": 0,
    "patches_in_throat": 0,
    "irregular_sugar_level": 0,
    "cough": 0,
    "high_fever": 0,
    "sunken_eyes": 0,
    "breathlessness": 0,
    "sweating": 0,
    "dehydration": 0,
    "indigestion": 0,
    "headache": 0,
    "yellowish_skin": 0,
    "dark_urine": 0,
    "nausea": 0,
    "loss_of_appetite": 0,
    "pain_behind_the_eyes": 0,
    "back_pain": 0,
    "constipation": 0,
    "abdominal_pain": 0,
    "diarrhoea": 0,
    "mild_fever": 0,
    "yellow_urine": 0,
    "yellowing_of_eyes": 0,
    "acute_liver_failure": 0,
    "fluid_overload": 0,
    "swelling_of_stomach": 0,
    "swelled_lymph_nodes": 0,
    "malaise": 0,
    "blurred_and_distorted_vision": 0,
    "phlegm": 0,
    "throat_irritation": 0,
    "redness_of_eyes": 0,
    "sinus_pressure": 0,
    "runny_nose": 0,
    "congestion": 0,
    "chest_pain": 0,
    "weakness_in_limbs": 0,
    "fast_heart_rate": 0,
    "pain_during_bowel_movements": 0,
    "pain_in_anal_region": 0,
    "bloody_stool": 0,
    "irritation_in_anus": 0,
    "neck_pain": 0,
    "dizziness": 0,
    "cramps": 0,
    "bruising": 0,
    "obesity": 0,
    "swollen_legs": 0,
    "swollen_blood_vessels": 0,
    "puffy_face_and_eyes": 0,
    "enlarged_thyroid": 0,
    "brittle_nails": 0,
    "swollen_extremeties": 0,
    "excessive_hunger": 0,
    "extra_marital_contacts": 0,
    "drying_and_tingling_lips": 0,
    "slurred_speech": 0,
    "knee_pain": 0,
    "hip_joint_pain": 0,
    "muscle_weakness": 0,
    "stiff_neck": 0,
    "swelling_joints": 0,
    "movement_stiffness": 0,
    "spinning_movements": 0,
    "loss_of_balance": 0,
    "unsteadiness": 0,
    "weakness_of_one_body_side": 0,
    "loss_of_smell": 0,
    "bladder_discomfort": 0,
    "foul_smell_of urine": 0,
    "continuous_feel_of_urine": 0,
    "passage_of_gases": 0,
    "internal_itching": 0,
    "toxic_look_(typhos)": 0,
    "depression": 0,
    "irritability": 0,
    "muscle_pain": 0,
    "altered_sensorium": 0,
    "red_spots_over_body": 0,
    "belly_pain": 0,
    "abnormal_menstruation": 0,
    "dischromic _patches": 0,
    "watering_from_eyes": 0,
    "increased_appetite": 0,
    "polyuria": 0,
    "family_history": 0,
    "mucoid_sputum": 0,
    "rusty_sputum": 0,
    "lack_of_concentration": 0,
    "visual_disturbances": 0,
    "receiving_blood_transfusion": 0,
    "receiving_unsterile_injections": 0,
    "coma": 0,
    "stomach_bleeding": 0,
    "distention_of_abdomen": 0,
    "history_of_alcohol_consumption": 0,
    "fluid_overload.1": 0,
    "blood_in_sputum": 0,
    "prominent_veins_on_calf": 0,
    "palpitations": 0,
    "painful_walking": 0,
    "pus_filled_pimples": 0,
    "blackheads": 0,
    "scurring": 0,
    "skin_peeling": 0,
    "silver_like_dusting": 0,
    "small_dents_in_nails": 0,
    "inflammatory_nails": 0,
    "blister": 0,
    "red_sore_around_nose": 0,
    "yellow_crust_ooze": 0,
  };
  final Map<String, List<String>> organsSymptoms = {
    'head': [
      'itching',
      'skin_rash',
      'nodal_skin_eruptions',
      'continuous_sneezing',
      'shivering',
      'chills',
      'fatigue',
      'anxiety',
      'mood_swings',
      'restlessness',
      'patches_in_throat',
      'irregular_sugar_level',
      'cough',
      'high_fever',
      'sunken_eyes',
      'breathlessness',
      'sweating',
      'dehydration',
      'indigestion',
      'headache',
      'yellowish_skin',
      'dark_urine',
      'nausea',
      'loss_of_appetite',
      'pain_behind_the_eyes',
      'dizziness',
      'slurred_speech',
      'loss_of_smell',
      'toxic_look_(typhos)',
      'depression',
      'irritability',
      'altered_sensorium',
      'red_spots_over_body',
      'watering_from_eyes',
      'increased_appetite',
      'lack_of_concentration',
      'visual_disturbances',
      'coma',
      'stomach_bleeding',
      'history_of_alcohol_consumption',
      'receiving_blood_transfusion',
      'receiving_unsterile_injections'
    ],
    'arms': [
      'joint_pain',
      'muscle_wasting',
      'pain_behind_the_eyes',
      'neck_pain',
      'bruising',
      'prominent_veins_on_calf',
      'palpitations',
      'painful_walking'
    ],
    'legs': [
      'joint_pain',
      'muscle_wasting',
      'back_pain',
      'pain_during_bowel_movements',
      'pain_in_anal_region',
      'swollen_legs',
      'swollen_blood_vessels',
      'knee_pain',
      'hip_joint_pain',
      'muscle_weakness',
      'swelling_joints',
      'movement_stiffness',
      'spinning_movements',
      'loss_of_balance',
      'unsteadiness',
      'weakness_of_one_body_side',
      'painful_walking'
    ],
    'belly': [
      'stomach_pain',
      'acidity',
      'ulcers_on_tongue',
      'vomiting',
      'burning_micturition',
      'spotting_ urination',
      'constipation',
      'abdominal_pain',
      'diarrhoea',
      'mild_fever',
      'yellow_urine',
      'yellowing_of_eyes',
      'acute_liver_failure',
      'fluid_overload',
      'swelling_of_stomach',
      'swelled_lymph_nodes',
      'malaise',
      'phlegm',
      'throat_irritation',
      'redness_of_eyes',
      'sinus_pressure',
      'runny_nose',
      'congestion',
      'belly_pain',
      'abnormal_menstruation',
      'dischromic_patches',
      'foul_smell_of urine',
      'continuous_feel_of_urine',
      'passage_of_gases',
      'internal_itching',
      'distention_of_abdomen',
      'stomach_bleeding'
    ],
    'chest': [
      'cough',
      'chest_pain',
      'breathlessness',
      'mucoid_sputum',
      'rusty_sputum',
      'family_history',
      'loss_of_balance',
      'unsteadiness',
      'palpitations',
      'fast_heart_rate',
      'chest_pain'
    ],
    'groin area': [
      'irritation_in_anus',
      'drying_and_tingling_lips',
      'blurred_and_distorted_vision',
      'swollen_extremeties',
      'excessive_hunger',
      'extra_marital_contacts',
      'pain_in_anal_region',
      'bloody_stool',
      'irritation_in_anus',
      'brittle_nails',
      'inflammatory_nails',
      'blister',
      'red_sore_around_nose',
      'yellow_crust_ooze',
      'pus_filled_pimples',
      'blackheads',
      'scurring',
      'skin_peeling',
      'silver_like_dusting',
      'small_dents_in_nails'
    ]
  };
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [white, prmClr],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Primitive Diagnosis",
              style: subheadingStyle.copyWith(color: prmClr, fontSize: 18),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(7),
                child: SvgPicture.asset(
                  "assets/images/experts.svg",
                  height: SizeConfig.screenWidth * 0.07,
                  fit: BoxFit.fitHeight,
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        bodyChoose('head');
                      },
                      child: Image.asset("assets/images/body/head.png")),
                  Stack(
                    //alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.45,
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(math.pi),
                                  child: InkWell(
                                    child: InkWell(
                                      onTap: () {
                                        bodyChoose('arms');
                                      },
                                      child: Image.asset(
                                          "assets/images/body/left_hand.png"),
                                    ),
                                  )),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      bodyChoose('chest');
                                    },
                                    child: Image.asset(
                                        'assets/images/body/chest.png'),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        bodyChoose('belly');
                                      },
                                      child: Image.asset(
                                          'assets/images/body/below.png')),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  bodyChoose('arms');
                                },
                                child: Image.asset(
                                    'assets/images/body/left_hand.png'),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  bodyChoose('groin area');
                                },
                                child: Image.asset(
                                  'assets/images/body/organ.png',
                                  width: 80,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ],
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 135,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: InkWell(
                                        onTap: () {
                                          bodyChoose('legs');
                                        },
                                        child: Image.asset(
                                          'assets/images/body/leg.png',
                                          scale: 1.2,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        bodyChoose('legs');
                                      },
                                      child: Image.asset(
                                        'assets/images/body/leg.png',
                                        scale: 1.2,
                                      ),),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                  choosenItems.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.all(10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: choosenItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text(
                                        choosenItems[index],
                                        style: subtitleStyle.copyWith(
                                            color: darkHeaderClr),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              choosenItems.removeAt(index);
                                            });
                                          },
                                          icon: const Icon(Icons.delete))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.all(15),
                    child: Text(
                      'Search For Your Symptoms',
                      style: titleStyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextField(
                        onTapOutside: (event) {
                          _focusNode.unfocus();

                          setState(() {
                            // searchedFOrDoctors.clear();
                            //
                          });
                        },
                        focusNode: _focusNode,
                        onTap: () {},
                        onChanged: (value) {
                          if (controller.text.isNotEmpty) {
                            search();
                            setState(() {});
                          }
                          if (controller.text.isEmpty) {
                            searchedForItems.clear();
                            setState(() {});
                          }
                        },
                        onSubmitted: (value) {},
                        controller: controller,
                        decoration: InputDecoration(
                            fillColor: const Color.fromRGBO(0, 0, 0, 0.25),
                            filled: true,
                            hintText: 'Search for Symptoms',
                            hintStyle:
                                subtitleStyle.copyWith(color: Colors.white30),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            prefixIcon: Padding(
                                padding: const EdgeInsets.all(14),
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : const Icon(Icons.search))),
                      ),
                    ),
                  ),
                  (tapped || controller.text.isNotEmpty)
                      ? searchedForItems.isNotEmpty
                          ? Container(
                              height: 120,
                              width: 400,
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2.5,
                                ),
                                itemCount: searchedForItems.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      choosenItems.add(searchedForItems[index]);
                                      setState(() {});
                                    },
                                    child: Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        child: Text(
                                          searchedForItems[index],
                                          style: subtitleStyle.copyWith(
                                              color: darkHeaderClr),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.all(10),
                              child: Text(
                                'No Symptoms matched',
                                style: body2Style,
                              ),
                            )
                      : Container(),
                  InkWell(
                      onTap: () async {
                        if (choosenItems.length >= 3) {
                          choosenItems.forEach((element) {
                            mapSymptoms[element] = 1;
                          });
                          //  log(mapSymptoms.toString());
                          await diagnose();
                        } else {
                          Alert(
                            context: context,
                            title: "Choose 3 Symptoms at least",
                            //     desc: "try again Later",
                            buttons: [
                              DialogButton(
                                onPressed: () => Navigator.pop(context),
                                color: const Color.fromRGBO(0, 179, 134, 1.0),
                                child: const Text(
                                  "Close",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ],
                          ).show();
                        }
                      },
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const FormsButton(buttonText: 'Diagnose'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
