import 'dart:convert';

class User {
  final String? id;
  final String firstName;
  final String lastName;
  final String role;
  final String? rate;

  final String? token;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.rate,
      required this.role,
      this.token});

  factory User.fromjson(json) {
    return User(
        firstName: json['firstName'],
        lastName: json['lastName'],
        id: json['id'],
        role: json['role']);
  }
}

class Specialization {
  final String id;
  final String title;

  Specialization({required this.id, required this.title});
  factory Specialization.fromjson(json) {
    return Specialization(id: json['id'], title: json['title']);
  }
}

class WorkAppointment {
  final String day;
  final String to;
  final String from;

  WorkAppointment({required this.day, required this.to, required this.from});
  factory WorkAppointment.fromjson(json) {
    return WorkAppointment(
        day: json[0]['day'], to: json[0]['to'], from: json[0]['from']);
  }
}

class Clinic {
  final String clinicName;
  final String id;
  final String address;
  final String phoneNumber;
  final int? price;
  final WorkAppointment? workAppointment;
  Clinic(
      {required this.phoneNumber,
      this.price,
      required this.clinicName,
      required this.id,
      required this.address,
      this.workAppointment});
  factory Clinic.fromjson(json) {
    return Clinic(
      clinicName: json['name'],
      address: json['address'],
      id: json['id'],
      phoneNumber: json['phone'],
      price: json['reservationPrice'],
      workAppointment: WorkAppointment.fromjson(json['workAppointments']),
    );
  }
  factory Clinic.fromjson2(json) {
    return Clinic(
      clinicName: json['name'],
      address: json['address'],
      id: json['id'],
      phoneNumber: json['phone'],
    );
  }
  static dynamic toJson(
    String name,
    String address,
    String phone,
    int price,
    String from,
    String to,
  ) =>
      {
        "name": name,
        "phone": phone,
        "address": address,
        "reservationPrice": price,
        "workAppointments": [
          {"day": 'sat', "from": from, "to": to}
        ]
      };
}

class Review {
  final String description;
  final String title;
  final String? id;
  final int rate;
  Patient? patient;

  Review(
      {required this.description,
      required this.title,
      required this.rate,
      this.id,
      this.patient});
  factory Review.fromjson(json) {
    return Review(
        description: json['description'],
        title: json['title'],
        rate: json['rate'],
        patient: Patient.fromReviewjson(json['patient']));
  }
  factory Review.fromjson2(json) {
    return Review(
        description: json['description'],
        title: json['title'],
        rate: json['rate'],
        id: json['id']);
  }
}

class Chat {
  final String id;
  final String name;
  final String? patientId;

  Chat( {required this.id,this.patientId, required this.name});
  factory Chat.fromjson(json) {
    // Map<String, dynamic> json=jsonDecode(jsonData) ;
    return Chat(id: json['id'], name: json['name'],patientId: json['patientId']);
  }
}

class Message {
  final String id;
  final String content;
  final String? attachedFileUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String chatId;
  final String senderId;

  Message({
    required this.id, 
    required this.content, 
    this.attachedFileUrl, 
    required this.createdAt, 
    required this.updatedAt, 
    required this.chatId, 
    required this.senderId
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      attachedFileUrl: json['attachedFileUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      chatId: json['chatId'],
      senderId: json['senderId'],
    );
  }
}

class Consultation {
  final String id;
  String? patientName;
  String? docName;
  Doctor? doc;
  Patient? patient;
  String? patientId;
  Chat? chat;

  Consultation(this.id, {this.chat, this.patient, this.doc, this.patientId});
  factory Consultation.fromjson(json) {
    return Consultation(json['id'], chat: Chat.fromjson(json['chat']));
  }
  factory Consultation.fromjson2(json) {
    return Consultation(json['id'], patientId: json['patientId']);
  }
}

class Disease {
  final String id;
  final String? name;
  final String? desc;
  factory Disease.fromjson(json) {
    return Disease(id: json['id'], name: json['name'], desc: json['description']);
  }

  Disease({required this.id, required this.name, required this.desc});
}

class Patient {
  final String firstName;
  final String lastName;
  final String? gender;
  final String id;
  final String? email;
  String? patientToken;
  List<Disease>? disease = [];
  Patient(
      {required this.firstName,
      required this.lastName,
       this.gender,
      required this.id,
      this.email,
      this.disease,
      this.patientToken});
  static dynamic toJson(
    String fname,
    String lname,
    String email,
    String gender,
    String password,
  ) =>
      {
        'firstName': fname,
        'email': email,
        'lastName': lname,
        'password': password,
        'gender': gender,
      };
  factory Patient.fromjson(json) {
    List<dynamic> jsonListReviews = json['previousDiseases'];
    List<Map<String, dynamic>> mapListReviews = [];

    for (dynamic jsonItem in jsonListReviews) {
      Map<String, dynamic> mapItem = jsonItem as Map<String, dynamic>;
      mapListReviews.add(mapItem);
    }

    return Patient(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        gender: json['gender'],
        id: json['id'],
        disease: mapListReviews.map((e) => Disease.fromjson(e)).toList(),);
  }
  factory Patient.fromReviewjson(json) {
    return Patient(
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      id: json['id'],
    );
  }
  factory Patient.fromChatjson(json) {
    return Patient(
      firstName: json['firstName'],
      lastName: json['lastName'],
      id: json['id'],
    );
  }
}

class Doctor {
  final String? id;
  final String firstName;
  final String lastName;
  final String? rate;
  final String? email;

  final String? medicalSpecialization;
  String? token;
  Specialization? specialization;
  Doctor(this.firstName, this.lastName, this.email,
      {this.medicalSpecialization,
      this.id,
      this.token,
      this.rate,
      this.specialization});
  static dynamic toJson(String fname, String lname, String email, String gender,
          String nationalId, String password, String specialization) =>
      {
        'firstName': fname,
        'email': email,
        'lastName': lname,
        'password': password,
        'gender': gender,
        'nationalId': nationalId,
        'specializationId': specialization,
      };
  factory Doctor.fromjson(jsonData) {
    return Doctor(
      jsonData['firstName'],
      jsonData['lastName'],
      jsonData['email'],
      medicalSpecialization: jsonData['medicalSpecialization'],
      id: jsonData['id'],
    );
  }
  factory Doctor.fromjson2(jsonData) {
    return Doctor(
      jsonData['firstName'],
      jsonData['lastName'],
      jsonData['email'],
      specialization: Specialization.fromjson(jsonData['specialization']),
      id: jsonData['id'],
    );
  }
}

class SearchedDoctor {
  final String id;
  final String firstName;
  final String lastName;
  final String? rate;
  final String? email;
  final List<Clinic>? clinics;
  final List<Review>? reviews;

  final String? medicalSpecialization;
  String? token;
  Specialization? specialization;
  SearchedDoctor(
      {required this.firstName,
      required this.lastName,
      this.rate,
      this.email,
      this.medicalSpecialization,
      required this.id,
      this.token,
      this.clinics,
      this.reviews,
      this.specialization});

  factory SearchedDoctor.fromjson(jsonData) {
    List<dynamic> jsonList = jsonData['clincs'];
    List<Map<String, dynamic>> mapList = [];

    for (dynamic jsonItem in jsonList) {
      Map<String, dynamic> mapItem = jsonItem as Map<String, dynamic>;
      mapList.add(mapItem);
    }
    List<dynamic> jsonListReviews = jsonData['reviews'];
    List<Map<String, dynamic>> mapListReviews = [];

    for (dynamic jsonItem in jsonListReviews) {
      Map<String, dynamic> mapItem = jsonItem as Map<String, dynamic>;
      mapListReviews.add(mapItem);
    }
    return SearchedDoctor(
        firstName: jsonData['firstName'],
        lastName: jsonData['lastName'],
        email: jsonData['email'],
        medicalSpecialization: jsonData['medicalSpecialization'],
        specialization: Specialization.fromjson(jsonData['specialization']),
        id: jsonData['id'],
        clinics: mapList.map((review) => Clinic.fromjson2(review)).toList(),
        reviews:
            mapListReviews.map((review) => Review.fromjson2(review)).toList(),);
  }
}








class Appointment {
  String id;
  String chatId;
  DateTime appointment;
  DateTime updatedAt;
  Patient patient;

  Appointment({
    required this.id,
    required this.chatId,
    required this.appointment,
    required this.updatedAt,
    required this.patient,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      chatId: json['chatId'],
      appointment: DateTime.parse(json['appointment']),
      updatedAt: DateTime.parse(json['updatedAt']),
      patient: Patient.fromChatjson(json['patient']),
    );
  }
}







// class Disease {
//   final String id;
//   final String name;
//   final String description;
//   List<Patient> patients = [];
//   List<Prescription> prescriptions = [];

//   Disease(this.id, this.name, this.description);
// }

// class Medicine {
//   final String id;
//   final String name;
//   List<Patient> patients = [];
//   List<Prescription> prescriptions = [];

//   Medicine(this.id, this.name);
// }

// class Prescription {
//   final String id;
//   final String dignose;
//   final String requriedRays;
//   final String requiredTests;
//   List<Medicine> medicines = [];
//   List<Disease> diseases = [];
//   List<OfflineConsultation> consultation = [];

//   Prescription(this.id, this.dignose, this.requriedRays, this.requiredTests);
// }

// class Patient {
//   final String id;
//   final String firstName;
//   final String midName;
//   final String lastName;
//   final GENDER gender;
//   final String nationalId;
//   final String bloodGroup;
//   final String weight;
//   final String height;
//   int? age;
//   bool isBlocked = false;
//   final String email;
//   final DateTime? resetPasswordToken;
//   DateTime? resertPasswordTokenExpires;
//   List<DoctorReview> doctorReviews = [];
//   List<PatientReports> patientReports = [];
//   List<Disease> previousDiseases = [];
//   List<Medicine> previousMedicines = [];
//   List<OfflineConsultation> offlineConsultations = [];
//   List<OnlineConsultations> onlineConsultations = [];

//   Patient(
//       this.id,
//       this.firstName,
//       this.midName,
//       this.lastName,
//       this.gender,
//       this.nationalId,
//       this.bloodGroup,
//       this.weight,
//       this.height,
//       this.email,
//       this.resetPasswordToken);
// }

// class DoctorReview {
//   final String id;
//   final int rate;
//   String? title;
//   final String description;
//   final Doctor doctor;
//   final String doctorId;
//   final Patient patient;
//   final String patientId;

//   DoctorReview(this.id, this.title, this.description, this.doctorId,
//       this.patientId, this.rate, this.patient, this.doctor);
// }

// class PatientReports {
//   final String id;
//   final String title;
//   final String description;
//   final DateTime createdAt;
//   DateTime? updatedAt;
//   final Patient patient;
//   final Doctor doctor;
//   final String patientId;
//   final String doctorId;

//   PatientReports(this.id, this.title, this.description, this.patientId,
//       this.doctorId, this.createdAt, this.patient, this.doctor);
// }

// class Doctor{
//   final String id;
//   final String firstName;
//   final String midName;
//   final String lastName;
//   final GENDER gender;
//   final String nationalId;
//   final String email;
//   final String password;
//   bool isBlocked = false;
//   bool isVeriyfied = true;
//   int? onlineExaminationPrice;
//   DateTime? resetPasswordToken;
//   DateTime? resertPasswordTokenExpires;
//   List<DoctorReview> reviews = [];
//   List<Certificate> certificates = [];
//   List<Clinc> clincs = [];
//   List<WorkAppointments> onlineWorkAppointments = [];
//   final MedicalSpecialization specialization;
//   final String medicalSpecializationId;
//   List<PatientReports> patientReports = [];
//   List<OnlineConsultations> onlineConsultations = [];

//   Doctor(
//       this.id,
//       this.firstName,
//       this.midName,
//       this.lastName,
//       this.gender,
//       this.nationalId,
//       this.email,
//       this.password,
//       this.medicalSpecializationId,
//       this.specialization);
// }

class MedicalSpecialization {
  String id;
  String title;
  String? description;
  //List<Doctor> doctors = [];

  MedicalSpecialization(
      {required this.id, required this.title, this.description});

  factory MedicalSpecialization.fromjson(jsonData) {
    return MedicalSpecialization(
        id: jsonData['id'],
        title: jsonData['title'],
        description: jsonData['description']);
  }
}

// class Clinc {
//   final String id;
//   final String name;
//   final String? phone;
//   final String? address;
//   int? reservationPrice;
//   final Doctor doctor;
//   final String doctorId;
//   List<WorkAppointments> workAppointments = [];
//   List<OfflineConsultation> consultations = [];

//   Clinc(
//       this.id, this.name, this.phone, this.address, this.doctor, this.doctorId);
// }

// class WorkAppointments {
//   final String id;
//   final String day;
//   final String from;
//   final String to;
//   Clinc? clinc;
//   final String clincId;
//   final Doctor doctor;
//   final String doctorId;

//   WorkAppointments(this.id, this.day, this.from, this.to, this.clincId,
//       this.doctor, this.doctorId);
// }

// class Certificate {
//   final String id;
//   final String destination;
//   final String imageUrl;
//   final Doctor doctor;
//   final String doctorId;

//   Certificate(
//       this.id, this.destination, this.imageUrl, this.doctor, this.doctorId);
// }

// class OfflineConsultation {
//   final String id;
//   final DateTime appointment;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   final Clinc clinc;
//   final String clincId;
//   final Patient patient;
//   final String patientId;
//   Prescription? prescription;
//   final String prescriptionId;

//   OfflineConsultation(this.id, this.clinc, this.clincId, this.patientId,
//       this.prescriptionId, this.patient, this.appointment);
// }

// class OnlineConsultations {
//   final String id;
//   final DateTime appointment;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   final Doctor doctor;
//   final String doctorId;
//   final Patient patient;
//   final String patientId;
//   final Chat chat;

//   OnlineConsultations(this.id, this.appointment, this.doctor, this.doctorId,
//       this.patient, this.patientId, this.chat);
// }

// class Chat {
//   final String id;
//   final String name;
//   final List<Message> messages;
//   final OnlineConsultations consultation;
//   final String onlineConsultationsId;

//   Chat(this.id, this.name, this.messages, this.onlineConsultationsId,
//       this.consultation);
// }

// class Message {
//   final String id;
//   final String content;
//   final String attachedFileUrl;
//   final DateTime createdAt;
//   DateTime? updatedAt;
//   final Chat chat;
//   final String chatId;
//   final String senderId;

//   Message(this.id, this.content, this.attachedFileUrl, this.chatId,
//       this.senderId, this.createdAt, this.chat);
// }

// class Admin {
//   final String id;
//   final String firstName;
//   final String midName;
//   final String lastName;
//   final String email;
//   final String password;

//   Admin(this.id, this.firstName, this.midName, this.lastName, this.email,
//       this.password);
// }

// enum GENDER { male, female }

// class User {
//   final String id;
//   final String email;
//   final String password;
//   final String firstName;
//   final String midName;
//   final String lastName;
//   final String role;

//   User(this.id, this.email, this.password, this.firstName, this.midName,
//       this.lastName, this.role);
// }

// class DoctorDetails {
//   final String id;
//   final String firstName;
//   final String midName;
//   final String lastName;
//   int? rate;
//   final String medicalSpecialization;

//   DoctorDetails(this.id, this.firstName, this.midName, this.lastName,
//       this.medicalSpecialization);
// }
