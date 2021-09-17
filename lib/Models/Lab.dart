class Lab {
  int _id;
  User _user;
  int _latitude;
  int _longitude;
  String _timeFrom;
  String _timeTo;

  Lab(
      {int id,
        User user,
        int latitude,
        int longitude,
        String timeFrom,
        String timeTo}) {
    this._id = id;
    this._user = user;
    this._latitude = latitude;
    this._longitude = longitude;
    this._timeFrom = timeFrom;
    this._timeTo = timeTo;
  }

  int get id => _id;
  set id(int id) => _id = id;
  User get user => _user;
  set user(User user) => _user = user;
  int get latitude => _latitude;
  set latitude(int latitude) => _latitude = latitude;
  int get longitude => _longitude;
  set longitude(int longitude) => _longitude = longitude;
  String get timeFrom => _timeFrom;
  set timeFrom(String timeFrom) => _timeFrom = timeFrom;
  String get timeTo => _timeTo;
  set timeTo(String timeTo) => _timeTo = timeTo;

  // Lab.fromJson(Map<String, dynamic> json) {
  //   _id = json['id'];
  //   _user = json['user'] != null ? new User.fromJson(json['user']) : null;
  //   _latitude = json['latitude'];
  //   _longitude = json['longitude'];
  //   _timeFrom = json['timeFrom'];
  //   _timeTo = json['timeTo'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this._id;
  //   if (this._user != null) {
  //     data['user'] = this._user.toJson();
  //   }
  //   data['latitude'] = this._latitude;
  //   data['longitude'] = this._longitude;
  //   data['timeFrom'] = this._timeFrom;
  //   data['timeTo'] = this._timeTo;
  //   return data;
  // }
}

class User {
  int _id;
  String _name;
  String _email;
  bool _isActive;
  String _address;

  User({int id, String name, String email, bool isActive, String address}) {
    this._id = id;
    this._name = name;
    this._email = email;
    this._isActive = isActive;
    this._address = address;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get email => _email;
  set email(String email) => _email = email;
  bool get isActive => _isActive;
  set isActive(bool isActive) => _isActive = isActive;
  String get address => _address;
  set address(String address) => _address = address;

  // User.fromJson(Map<String, dynamic> json) {
  //   _id = json['id'];
  //   _name = json['name'];
  //   _email = json['email'];
  //   _isActive = json['isActive'];
  //   _address = json['address'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this._id;
  //   data['name'] = this._name;
  //   data['email'] = this._email;
  //   data['isActive'] = this._isActive;
  //   data['address'] = this._address;
  //   return data;
  // }
}