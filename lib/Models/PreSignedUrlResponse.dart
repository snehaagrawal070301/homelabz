class PreSignedUrlResponse {
  int userId;
  String documentCategoryEnum;
  List<DocumentPresignedURLModelList> documentPresignedURLModelList;

  PreSignedUrlResponse(
      {this.userId,
        this.documentCategoryEnum,
        this.documentPresignedURLModelList});

  PreSignedUrlResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    documentCategoryEnum = json['documentCategoryEnum'];
    if (json['documentPresignedURLModelList'] != null) {
      documentPresignedURLModelList = new List<DocumentPresignedURLModelList>();
      json['documentPresignedURLModelList'].forEach((v) {
        documentPresignedURLModelList
            .add(new DocumentPresignedURLModelList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['documentCategoryEnum'] = this.documentCategoryEnum;
    if (this.documentPresignedURLModelList != null) {
      data['documentPresignedURLModelList'] =
          this.documentPresignedURLModelList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentPresignedURLModelList {
  String keyName;
  String keyPath;
  String presignedURL;

  DocumentPresignedURLModelList(
      {this.keyName, this.keyPath, this.presignedURL});

  DocumentPresignedURLModelList.fromJson(Map<String, dynamic> json) {
    keyName = json['keyName'];
    keyPath = json['keyPath'];
    presignedURL = json['presignedURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyName'] = this.keyName;
    data['keyPath'] = this.keyPath;
    data['presignedURL'] = this.presignedURL;
    return data;
  }
}