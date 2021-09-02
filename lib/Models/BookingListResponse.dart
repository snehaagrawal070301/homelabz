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
  Lab lab;
  String dob;
  String gender;
  bool isASAP;
  String address;
  double latitude;
  String bookingStatus;

  UpcomingBookingList(
      {this.id,
        this.patient,
        this.bookedBy,
        this.lab,
        this.dob,
        this.gender,
        this.isASAP,
        this.address,
        this.latitude,
        this.bookingStatus});

  UpcomingBookingList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient =
    json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    bookedBy = json['bookedBy'] != null
        ? new BookedBy.fromJson(json['bookedBy'])
        : null;
    lab = json['lab'] != null ? new Lab.fromJson(json['lab']) : null;
    dob = json['dob'];
    gender = json['gender'];
    isASAP = json['isASAP'];
    address = json['address'];
    latitude = json['latitude'];
    bookingStatus = json['bookingStatus'];
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
    if (this.lab != null) {
      data['lab'] = this.lab.toJson();
    }
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['isASAP'] = this.isASAP;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['bookingStatus'] = this.bookingStatus;
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

class Lab {
  int id;
  BookedBy user;
  double latitude;
  double longitude;

  Lab({this.id, this.user, this.latitude, this.longitude});

  Lab.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new BookedBy.fromJson(json['user']) : null;
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