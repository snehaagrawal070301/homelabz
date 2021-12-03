

import 'dart:io';

class FolderDetailsResponse {
  File imageFile;
  bool isLocal = false;
  int id;
  String name;
  String path;
  String category;
  User user;

  // bool get isLocal => _isLocal;
  //
  // set isLocal(bool value) {
  //   _isLocal = value;
  // }

  FolderDetailsResponse({this.id, this.name, this.path, this.category, this.user});

  FolderDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    category = json['category'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['path'] = this.path;
    data['category'] = this.category;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;

  User({this.id});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}