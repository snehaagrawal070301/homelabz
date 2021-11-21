class CompletedBookingResponse {
  List<CompletedBookingList> completedBookingList;

  CompletedBookingResponse({this.completedBookingList});

  CompletedBookingResponse.fromJson(Map<String, dynamic> json) {
    if (json['completedBookingList'] != null) {
      completedBookingList = new List<CompletedBookingList>();
      json['completedBookingList'].forEach((v) {
        completedBookingList.add(new CompletedBookingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.completedBookingList != null) {
      data['completedBookingList'] =
          this.completedBookingList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompletedBookingList {
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
  String timeTo;
  String address;
  String bookingStatus;
  double amount;
  String notes;
  String paymentStatus;
  String paymentDate;
  Phlebotomist doctor;
  String reportReceivedOn;

  CompletedBookingList(
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
        this.notes,
        this.paymentStatus,
        this.paymentDate,
        this.doctor,
        this.reportReceivedOn});

  CompletedBookingList.fromJson(Map<String, dynamic> json) {
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
    timeTo = json['timeTo'];
    address = json['address'];
    bookingStatus = json['bookingStatus'];
    amount = json['amount'];
    notes = json['notes'];
    paymentStatus = json['paymentStatus'];
    paymentDate = json['paymentDate'];
    doctor = json['doctor'] != null
        ? new Phlebotomist.fromJson(json['doctor'])
        : null;
    reportReceivedOn = json['reportReceivedOn'];
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
    data['notes'] = this.notes;
    data['paymentStatus'] = this.paymentStatus;
    data['paymentDate'] = this.paymentDate;
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    data['reportReceivedOn'] = this.reportReceivedOn;
    return data;
  }
}

class Patient {
  int id;
  String name;
  String mobileNumber;
  String address;
  String imagePath;

  Patient(
      {this.id, this.name, this.mobileNumber, this.address, this.imagePath});

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

  BookedBy({this.id, this.role, this.name});

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
  User user;
  double latitude;
  double longitude;

  Lab({this.id, this.user, this.latitude, this.longitude});

  Lab.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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

class User {
  int id;
  String name;
  String mobileNumber;
  String address;

  User({this.id, this.name, this.mobileNumber, this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    return data;
  }
}