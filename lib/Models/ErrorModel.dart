class ErrorModel {
  String timestamp;
  String message;
  Null details;

  ErrorModel({this.timestamp, this.message, this.details});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    message = json['message'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['message'] = this.message;
    data['details'] = this.details;
    return data;
  }
}