class LabResponse {
  int id;
  User user;
  String latitude;
  String longitude;

  LabResponse({this.id, this.user, this.latitude, this.longitude});

  LabResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
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
  String email;
  bool isActive;
  bool isVerified;
  String mobileNumber;
  String address;
  String dob;
  String gender;

  User(
      {this.id,
        this.name,
        this.email,
        this.isActive,
        this.isVerified,
        this.mobileNumber,
        this.address,
        this.dob,
        this.gender});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    isActive = json['isActive'];
    isVerified = json['isVerified'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    dob = json['dob'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['isActive'] = this.isActive;
    data['isVerified'] = this.isVerified;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    return data;
  }
}