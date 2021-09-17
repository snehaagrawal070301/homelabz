class LabResponse {
  int id;
  // User user;
  int latitude;
  int longitude;
  String timeFrom;
  String timeTo;


  LabResponse(
      {this.id,
        // this.user,
        this.latitude,
        this.longitude,
        this.timeFrom,
        this.timeTo});

  LabResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // user = json['user'] != null ? new User.fromJson(json['user']) : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
    timeFrom = json['timeFrom'];
    timeTo = json['timeTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    // if (this.user != null) {
    //   data['user'] = this.user.toJson();
    // }
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['timeFrom'] = this.timeFrom;
    data['timeTo'] = this.timeTo;
    return data;
  }
}

// class User {
//   int id;
//   String name;
//   String email;
//   bool isActive;
//   String address;
//
//   User({this.id, this.name, this.email, this.isActive, this.address});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     isActive = json['isActive'];
//     address = json['address'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['isActive'] = this.isActive;
//     data['address'] = this.address;
//     return data;
//   }
// }