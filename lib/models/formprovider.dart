import 'package:flutter/material.dart';
import 'package:flutter_project/models/classes.dart';

class CoDoctorProvider extends ChangeNotifier {
  Doctor registeredDoctor = Doctor(
    '',
    '',
    '',
    medicalSpecialization: '',
  );

  Patient registeredPatient =Patient(firstName: '',
       lastName: '', gender: '',
        id: '',
         email: '');

  String chatId = '';

  Consultation consultation = Consultation('');

  Chat chat = Chat(id: '', name: '');

  String userId = '';

  String token='007eJxTYBDufqSwIdAkfqN9vOXpxg17lKYICAu1mpvV/uTW/qb06pACg5GZcbKJkbmhUWKquYmBhWFiirmRqYWZqWVaSqqpeZJRVXR/SkMgIwOL92QGRigE8fkZ3HJKS0pSi5zzU/KTS/KLGBgA0WcgvA==';
String appId='263c42712ae74081ad7258659fde57b2';

  SearchedDoctor docSearched =
      SearchedDoctor(firstName: '', lastName: '', id: '');

  Patient patientChattedWith =
      Patient(firstName: '', lastName: '', gender: '', id: '', email: '');

  String chatPatientId = '';

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();

  TextEditingController firsName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController nationalId = TextEditingController();
  TextEditingController certificate = TextEditingController();
  String gender = 'Male';
  TimeOfDay selectedhours = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  updateDate(DateTime val) {
    selectedDate = val;
    notifyListeners();
  }

  updateHours(TimeOfDay val) {
    selectedhours = val;
    notifyListeners();
  }
  // String? get email => _email;
  // String? get password => _password;
  // String? get phoneNumber => _phoneNumber;
  // String? get fullName => _fullName;
  // bool? get isLoading => _isLoading;
  // set setpassword(String value) {
  //   _password = value;
  //   notifyListeners();
  // }

  // set setEmail(String value) {
  //   _email = value;
  //   notifyListeners();
  // }

  // set setphoneNumber(String value) {
  //   _phoneNumber = value;
  //   notifyListeners();
  // }

  // set setisLoading(bool value) {
  //   _isLoading = value;
  //   notifyListeners();
  // }

  // set setfullName(String value) {
  //   _fullName = value;
  //   notifyListeners();
  // }
}
