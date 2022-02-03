// class BookingListResponse {
//   List<UpcomingBookingList> upcomingBookingList;
//
//   BookingListResponse({this.upcomingBookingList});
//
//   BookingListResponse.fromJson(Map<String, dynamic> json) {
//     if (json['upcomingBookingList'] != null) {
//       upcomingBookingList = new List<UpcomingBookingList>();
//       json['upcomingBookingList'].forEach((v) {
//         upcomingBookingList.add(new UpcomingBookingList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.upcomingBookingList != null) {
//       data['upcomingBookingList'] =
//           this.upcomingBookingList.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class UpcomingBookingList {
//   int id;
//   Patient patient;
//   BookedBy bookedBy;
//   Patient phlebotomist;
//   String date;
//   Lab lab;
//   String dob;
//   String gender;
//   bool isASAP;
//   String timeFrom;
//   String address;
//   String bookingStatus;
//   double amount;
//
//   UpcomingBookingList(
//       {this.id,
//         this.patient,
//         this.bookedBy,
//         this.phlebotomist,
//         this.date,
//         this.lab,
//         this.dob,
//         this.gender,
//         this.isASAP,
//         this.timeFrom,
//         this.address,
//         this.bookingStatus,
//         this.amount});
//
//   UpcomingBookingList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     patient =
//     json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
//     bookedBy = json['bookedBy'] != null
//         ? new BookedBy.fromJson(json['bookedBy'])
//         : null;
//     phlebotomist = json['phlebotomist'] != null
//         ? new Patient.fromJson(json['phlebotomist'])
//         : null;
//     date = json['date'];
//     lab = json['lab'] != null ? new Lab.fromJson(json['lab']) : null;
//     dob = json['dob'];
//     gender = json['gender'];
//     isASAP = json['isASAP'];
//     timeFrom = json['timeFrom'];
//     address = json['address'];
//     bookingStatus = json['bookingStatus'];
//     amount = json['amount'];
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

class BookingListResponse {
  List<UpcomingBookingList> upcomingBookingList;

  BookingListResponse({this.upcomingBookingList});

  BookingListResponse.fromJson(Map<String, dynamic> json) {
    if (json['upcomingBookingList'] != null) {
      upcomingBookingList = new List<UpcomingBookingList>();
      json['upcomingBookingList'].forEach((v) {
        upcomingBookingList.add(new UpcomingBookingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.upcomingBookingList != null) {
      data['upcomingBookingList'] =
          this.upcomingBookingList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpcomingBookingList {
  int id;
  Patient patient;
  BookedBy bookedBy;
  Patient phlebotomist;
  String date;
  Lab lab;
  String dob;
  String gender;
  bool isASAP;
  String timeFrom;
  String timeTo;
  String address;
  String bookingStatus;
  double amount;
  Patient doctor;
  String notes;
  String paymentStatus;
  String paymentDate;

  UpcomingBookingList(
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
        this.timeTo,
        this.address,
        this.bookingStatus,
        this.amount,
        this.doctor,
        this.notes,
      this.paymentStatus,
      this.paymentDate});

  UpcomingBookingList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient =
    json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    bookedBy = json['bookedBy'] != null
        ? new BookedBy.fromJson(json['bookedBy'])
        : null;
    phlebotomist = json['phlebotomist'] != null
        ? new Patient.fromJson(json['phlebotomist'])
        : null;
    date = json['date'];
    lab = json['lab'] != null ? new Lab.fromJson(json['lab']) : null;
    dob = json['dob'];
    gender = json['gender'];
    isASAP = json['isASAP'];
    timeFrom = json['timeFrom'];
    timeTo = json['timeTo'];
    address = json['address'];
    bookingStatus = json['bookingStatus'];
    amount = json['amount'];
    doctor =
    json['doctor'] != null ? new Patient.fromJson(json['doctor']) : null;
    notes = json['notes'];
    paymentStatus = json['paymentStatus'];
    paymentDate = json['paymentDate'];
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
    data['timeTo'] = this.timeTo;
    data['address'] = this.address;
    data['bookingStatus'] = this.bookingStatus;
    data['amount'] = this.amount;
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    data['notes'] = this.notes;
    data['paymentStatus'] = this.paymentStatus;
    data['paymentDate'] = this.paymentDate;
    return data;
  }
}

class Patient {
  int id;
  String name;
  String mobileNumber;
  String address;
  String imagePath;

  Patient({this.id,
    this.name,
    this.mobileNumber,
    this.address,
    this.imagePath});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['imagePath'] = this.imagePath;
    return data;
  }
}

class BookedBy {
  int id;
  String role;
  String name;

  BookedBy({this.id, this.name});

  BookedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['name'] = this.name;
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




/////////
// class BookingListResponse {
//   List<UpcomingBookingList> upcomingBookingList;
//
//   BookingListResponse({this.upcomingBookingList});
//
//   BookingListResponse.fromJson(Map<String, dynamic> json) {
//     if (json['upcomingBookingList'] != null) {
//       upcomingBookingList = <UpcomingBookingList>[];
//       json['upcomingBookingList'].forEach((v) {
//         upcomingBookingList.add(new UpcomingBookingList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.upcomingBookingList != null) {
//       data['upcomingBookingList'] =
//           this.upcomingBookingList.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class UpcomingBookingList {
//   int id;
//   Patient patient;
//   BookedBy bookedBy;
//   Doctor doctor;
//   Lab lab;
//   String dob;
//   String gender;
//   bool isASAP;
//   String address;
//   String bookingStatus;
//   int amount;
//   String notes;
//   String paymentStatus;
//   String paymentDate;
//   Doctor phlebotomist;
//   String date;
//   String timeFrom;
//   String timeTo;
//   int latitude;
//
//   UpcomingBookingList(
//       {this.id,
//         this.patient,
//         this.bookedBy,
//         this.doctor,
//         this.lab,
//         this.dob,
//         this.gender,
//         this.isASAP,
//         this.address,
//         this.bookingStatus,
//         this.amount,
//         this.notes,
//         this.paymentStatus,
//         this.paymentDate,
//         this.phlebotomist,
//         this.date,
//         this.timeFrom,
//         this.timeTo,
//         this.latitude});
//
//   UpcomingBookingList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     patient =
//     json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
//     bookedBy = json['bookedBy'] != null
//         ? new BookedBy.fromJson(json['bookedBy'])
//         : null;
//     doctor =
//     json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
//     lab = json['lab'] != null ? new Lab.fromJson(json['lab']) : null;
//     dob = json['dob'];
//     gender = json['gender'];
//     isASAP = json['isASAP'];
//     address = json['address'];
//     bookingStatus = json['bookingStatus'];
//     amount = json['amount'];
//     notes = json['notes'];
//     paymentStatus = json['paymentStatus'];
//     paymentDate = json['paymentDate'];
//     phlebotomist = json['phlebotomist'] != null
//         ? new Doctor.fromJson(json['phlebotomist'])
//         : null;
//     date = json['date'];
//     timeFrom = json['timeFrom'];
//     timeTo = json['timeTo'];
//     latitude = json['latitude'];
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
//     if (this.doctor != null) {
//       data['doctor'] = this.doctor.toJson();
//     }
//     if (this.lab != null) {
//       data['lab'] = this.lab.toJson();
//     }
//     data['dob'] = this.dob;
//     data['gender'] = this.gender;
//     data['isASAP'] = this.isASAP;
//     data['address'] = this.address;
//     data['bookingStatus'] = this.bookingStatus;
//     data['amount'] = this.amount;
//     data['notes'] = this.notes;
//     data['paymentStatus'] = this.paymentStatus;
//     data['paymentDate'] = this.paymentDate;
//     if (this.phlebotomist != null) {
//       data['phlebotomist'] = this.phlebotomist.toJson();
//     }
//     data['date'] = this.date;
//     data['timeFrom'] = this.timeFrom;
//     data['timeTo'] = this.timeTo;
//     data['latitude'] = this.latitude;
//     return data;
//   }
// }
//
// class Patient {
//   int id;
//   String name;
//   String mobileNumber;
//   String address;
//   String imagePath;
//
//   Patient(
//       {this.id, this.name, this.mobileNumber, this.address, this.imagePath});
//
//   Patient.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     mobileNumber = json['mobileNumber'];
//     address = json['address'];
//     imagePath = json['imagePath'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['mobileNumber'] = this.mobileNumber;
//     data['address'] = this.address;
//     data['imagePath'] = this.imagePath;
//     return data;
//   }
// }
//
// class BookedBy {
//   int id;
//   String role;
//   String name;
//
//   BookedBy({this.id, this.role, this.name});
//
//   BookedBy.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     role = json['role'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['role'] = this.role;
//     data['name'] = this.name;
//     return data;
//   }
// }
//
// class Doctor {
//   int id;
//   String name;
//   String mobileNumber;
//   String imagePath;
//
//   Doctor({this.id, this.name, this.mobileNumber, this.imagePath});
//
//   Doctor.fromJson(Map<String, dynamic> json) {
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
// class Lab {
//   int id;
//   User user;
//   int latitude;
//   int longitude;
//
//   Lab({this.id, this.user, this.latitude, this.longitude});
//
//   Lab.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
//
// class User {
//   int id;
//   String name;
//   String mobileNumber;
//   String address;
//
//   User({this.id, this.name, this.mobileNumber, this.address});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     mobileNumber = json['mobileNumber'];
//     address = json['address'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['mobileNumber'] = this.mobileNumber;
//     data['address'] = this.address;
//     return data;
//   }
// }
