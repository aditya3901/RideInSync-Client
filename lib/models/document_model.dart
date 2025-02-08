class DocumentModel {
  List<RequiredDocs>? requiredDocs;

  DocumentModel({this.requiredDocs});

  DocumentModel.fromJson(Map<String, dynamic> json) {
    if (json['requiredDocs'] != null) {
      requiredDocs = <RequiredDocs>[];
      json['requiredDocs'].forEach((v) {
        requiredDocs!.add(RequiredDocs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (requiredDocs != null) {
      data['requiredDocs'] = requiredDocs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequiredDocs {
  String? sId;
  String? name;
  String? description;
  bool? uploaded;

  RequiredDocs({this.sId, this.name, this.description, this.uploaded});

  RequiredDocs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    uploaded = json['uploaded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['uploaded'] = uploaded;
    return data;
  }
}
