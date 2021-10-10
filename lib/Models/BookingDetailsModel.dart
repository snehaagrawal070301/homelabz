class BookingDetailsModel {
  int id;
  Patient patient;
  BookedBy bookedBy;
  Phlebotomist phlebotomist;
  String date;
  Lab lab;
  String dob;
  String gender;
  bool isASAP;
  String timeFrom;
  String address;
  String bookingStatus;
  double amount;
  String paymentStatus;

  BookingDetailsModel(
      {this.id,
        this.patient,
        this.bookedBy,
        this.phlebotomist,
        this.date,
        this.lab,
        this.dob,
        this.gender,
        this.isASAP,
        this.timeFrom,
        this.address,
        this.bookingStatus,
        this.amount,
        this.paymentStatus});

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient =
    json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    bookedBy = json['bookedBy'] != null
        ? new BookedBy.fromJson(json['bookedBy'])
        : null;
    phlebotomist = json['phlebotomist'] != null
        ? new Phlebotomist.fromJson(json['phlebotomist'])
        : null;
    date = json['date'];
    lab = json['lab'] != null ? new Lab.fromJson(json['lab']) : null;
    dob = json['dob'];
    gender = json['gender'];
    isASAP = json['isASAP'];
    timeFrom = json['timeFrom'];
    address = json['address'];
    bookingStatus = json['bookingStatus'];
    amount = json['amount'];
    paymentStatus = json['paymentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    if (this.bookedBy != null) {
      data['bookedBy'] = this.bookedBy.toJson();
    }
    if (this.phlebotomist != null) {
      data['phlebotomist'] = this.phlebotomist.toJson();
    }
    data['date'] = this.date;
    if (this.lab != null) {
      data['lab'] = this.lab.toJson();
    }
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['isASAP'] = this.isASAP;
    data['timeFrom'] = this.timeFrom;
    data['address'] = this.address;
    data['bookingStatus'] = this.bookingStatus;
    data['amount'] = this.amount;
    data['paymentStatus'] = this.paymentStatus;
    return data;
  }
}

class Patient {
  int id;
  String name;
  String mobileNumber;

  Patient({this.id, this.name, this.mobileNumber});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobileNumber'] = this.mobileNumber;
    return data;
  }
}

class BookedBy {
  int id;
  String name;

  BookedBy({this.id, this.name});

  BookedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Phlebotomist {
  int id;
  String name;
  String mobileNumber;
  String imagePath;

  Phlebotomist({this.id, this.name, this.mobileNumber, this.imagePath});

  Phlebotomist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobileNumber'] = this.mobileNumber;
    data['imagePath'] = this.imagePath;
    return data;
  }
}

class Lab {
  int id;
  Patient user;
  double latitude;
  double longitude;

  Lab({this.id, this.user, this.latitude, this.longitude});

  Lab.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new Patient.fromJson(json['user']) : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}


// class BookingDetailsModel {
//   int id;
//   Patient patient;
//   BookedBy bookedBy;
//   Patient phlebotomist;
//   Doctor doctor;
//   String date;
//   Lab lab;
//   String dob;
//   String gender;
//   bool isASAP;
//   String timeFrom;
//   String address;
//   String bookingStatus;
//   double amount;
//   String paymentStatus;
//
//   BookingDetailsModel(
//       {this.id,
//         this.patient,
//         this.bookedBy,
//         this.phlebotomist,
//         this.doctor,
//         this.date,
//         this.lab,
//         this.dob,
//         this.gender,
//         this.isASAP,
//         this.timeFrom,
//         this.address,
//         this.bookingStatus,
//         this.amount,
//         this.paymentStatus,}
//       );
//
//   BookingDetailsModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     patient =
//     json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
//     bookedBy = json['bookedBy'] != null
//         ? new BookedBy.fromJson(json['bookedBy'])
//         : null;
//     phlebotomist = json['phlebotomist'] != null
//         ? new Patient.fromJson(json['phlebotomist'])
//         : null;
//     doctor =
//     json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
//     date = json['date'];
//     lab = json['lab'] != null ? new Lab.fromJson(json['lab']) : null;
//     dob = json['dob'];
//     gender = json['gender'];
//     isASAP = json['isASAP'];
//     timeFrom = json['timeFrom'];
//     address = json['address'];
//     bookingStatus = json['bookingStatus'];
//     amount = json['amount'];
//     paymentStatus = json['paymentStatus'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.patient != null) {
//       data['patient'] = this.patient.toJson();
//     }
//     if (this.bookedBy != null) {
//       data['bookedBy'] = this.bookedBy.toJson();
//     }
//     if (this.phlebotomist != null) {
//       data['phlebotomist'] = this.phlebotomist.toJson();
//     }
//     if (this.doctor != null) {
//       data['doctor'] = this.doctor.toJson();
//     }
//     data['date'] = this.date;
//     if (this.lab != null) {
//       data['lab'] = this.lab.toJson();
//     }
//     data['dob'] = this.dob;
//     data['gender'] = this.gender;
//     data['isASAP'] = this.isASAP;
//     data['timeFrom'] = this.timeFrom;
//     data['address'] = this.address;
//     data['bookingStatus'] = this.bookingStatus;
//     data['amount'] = this.amount;
//     data['paymentStatus'] = this.paymentStatus;
//     return data;
//   }
// }
//
// class Patient {
//   int id;
//   String name;
//   String mobileNumber;
//   String imagePath;
//
//   Patient({this.id, this.name, this.mobileNumber, this.imagePath});
//
//   Patient.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     mobileNumber = json['mobileNumber'];
//     imagePath = json['imagePath'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['mobileNumber'] = this.mobileNumber;
//     data['imagePath'] = this.imagePath;
//     return data;
//   }
// }
//
// class BookedBy {
//   int id;
//   String name;
//
//   BookedBy({this.id, this.name});
//
//   BookedBy.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }
//
// class Doctor {
//   int id;
//   String name;
//   String mobileNumber;
//
//   Doctor({this.id, this.name, this.mobileNumber});
//
//   Doctor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     mobileNumber = json['mobileNumber'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['mobileNumber'] = this.mobileNumber;
//     return data;
//   }
// }
//
// class Lab {
//   int id;
//   BookedBy user;
//   String latitude;
//   String longitude;
//
//   Lab({this.id, this.user, this.latitude, this.longitude});
//
//   Lab.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     user = json['user'] != null ? new BookedBy.fromJson(json['user']) : null;
//     latitude = json['latitude'].toString();
//     longitude = json['longitude'].toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }
// }

// class BookingDetailsModel {
//   int id;
//   Patient patient;
//   BookedBy bookedBy;
//
//   String date;
//
//   Lab lab;
//   String dob;
//   String gender;
//   bool isASAP;
//
//   String timeFrom;
//   String timeTo;
//
//   String address;
//   double latitude;
//   String bookingStatus;
//
//   BookingDetailsModel(
//       {this.id,
//         this.patient,
//         this.bookedBy,
//         this.date,
//         this.lab,
//         this.dob,
//         this.gender,
//         this.isASAP,
//         this.timeFrom,
//         this.timeTo,
//         this.address,
//         this.latitude,
//         this.bookingStatus});
//
//   BookingDetailsModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     patient =
//     json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
//     bookedBy = json['bookedBy'] != null
//         ? new BookedBy.fromJson(json['bookedBy'])
//         : null;
//     date = json['date'];
//     lab = json['lab'] != null ? new Lab.fromJson(json['lab']) : null;
//     dob = json['dob'];
//     gender = json['gender'];
//     isASAP = json['isASAP'];
//     timeFrom = json['timeFrom'];
//     timeTo = json['timeTo'];
//     address = json['address'];
//     latitude = json['latitude'];
//     bookingStatus = json['bookingStatus'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.patient != null) {
//       data['patient'] = this.patient.toJson();
//     }
//     if (this.bookedBy != null) {
//       data['bookedBy'] = this.bookedBy.toJson();
//     }
//     data['date'] = this.date;
//     if (this.lab != null) {
//       data['lab'] = this.lab.toJson();
//     }
//     data['dob'] = this.dob;
//     data['gender'] = this.gender;
//     data['isASAP'] = this.isASAP;
//     data['timeFrom'] = this.timeFrom;
//     data['timeTo'] = this.timeTo;
//     data['address'] = this.address;
//     data['latitude'] = this.latitude;
//     data['bookingStatus'] = this.bookingStatus;
//     return data;
//   }
// }
//
// class Patient {
//   int id;
//   String name;
//   String mobileNumber;
//
//   Patient({this.id, this.name, this.mobileNumber});
//
//   Patient.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     mobileNumber = json['mobileNumber'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['mobileNumber'] = this.mobileNumber;
//     return data;
//   }
// }
//
// class BookedBy {
//   int id;
//   String name;
//
//   BookedBy({this.id, this.name});
//
//   BookedBy.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }
//
// class Lab {
//   int id;
//   BookedBy user;
//   double latitude;
//   double longitude;
//
//   Lab({this.id, this.user, this.latitude, this.longitude});
//
//   Lab.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     user = json['user'] != null ? new BookedBy.fromJson(json['user']) : null;
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }
// }