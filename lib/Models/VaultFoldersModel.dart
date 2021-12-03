class VaultFoldersModel {
  int id;
  String name;
  int noOfFiles;
  String createdDate;
  String updatedDate;

  VaultFoldersModel(
      {this.id, this.name, this.noOfFiles, this.createdDate, this.updatedDate});

  VaultFoldersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    noOfFiles = json['noOfFiles'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['noOfFiles'] = this.noOfFiles;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}