class OfficeModel {
  OfficeLocation? location;
  String? sId;
  String? company;
  String? name;
  String? address;

  OfficeModel({
    this.location,
    this.sId,
    this.company,
    this.name,
    this.address,
  });

  OfficeModel.fromJson(Map<String, dynamic> json) {
    location = OfficeLocation.fromJson(json['location']);
    sId = json['_id'];
    company = json['company'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location!.toJson();
    data['_id'] = sId;
    data['company'] = company;
    data['name'] = name;
    data['address'] = address;
    return data;
  }
}

class OfficeLocation {
  String? type;
  List<double>? coordinates;

  OfficeLocation({this.type, this.coordinates});

  OfficeLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
