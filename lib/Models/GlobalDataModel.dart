class GlobalDataModel {
  int id;
  String code;
  String value;

  GlobalDataModel({this.id, this.code, this.value});

  GlobalDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['value'] = this.value;
    return data;
  }
}
