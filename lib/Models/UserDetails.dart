class UserDetails {
  int id;
  String name;
  bool isActive;
  bool isVerified;
  String mobileNumber;
  String address;
  String dob;
  String education;
  String imagePath;
  String imagePresignedURL;
  String email;
  String gender;

  UserDetails(
      {this.id,
        this.name,
        this.isActive,
        this.isVerified,
        this.mobileNumber,
        this.address,
        this.dob,
        this.education,
        this.imagePath,
        this.imagePresignedURL,
        this.email,
        this.gender});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
    isVerified = json['isVerified'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    dob = json['dob'];
    education = json['education'];
    imagePath = json['imagePath'];
    imagePresignedURL = json['imagePresignedURL'];
    email = json['email'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    data['isVerified'] = this.isVerified;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['education'] = this.education;
    data['imagePath'] = this.imagePath;
    data['imagePresignedURL'] = this.imagePresignedURL;
    data['email'] = this.email;
    data['gender'] = this.gender;
    return data;
  }
}