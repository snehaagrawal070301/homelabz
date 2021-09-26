class DoctorResponse {
  int id;
  String name;
  String email;
  bool isActive;
  bool isVerified;
  String mobileNumber;

  DoctorResponse(
      {this.id,
        this.name,
        this.email,
        this.isActive,
        this.isVerified,
        this.mobileNumber});

  DoctorResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    isActive = json['isActive'];
    isVerified = json['isVerified'];
    mobileNumber = json['mobileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['isActive'] = this.isActive;
    data['isVerified'] = this.isVerified;
    data['mobileNumber'] = this.mobileNumber;
    return data;
  }
}