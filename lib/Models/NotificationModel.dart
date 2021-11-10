class NotificationModel {
  int id;
  String description;
  String type;
  String createdDate;

  NotificationModel({this.id, this.description, this.type, this.createdDate});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    type = json['type'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['type'] = this.type;
    data['createdDate'] = this.createdDate;
    return data;
  }
}