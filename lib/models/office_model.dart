class OfficeModel {
  OfficeLocation? location;
  String? sId;
  String? company;
  String? name;

  OfficeModel({
    this.location,
    this.sId,
    this.company,
    this.name,
  });

  OfficeModel.fromJson(Map<String, dynamic> json) {
    location = OfficeLocation.fromJson(json['address']);
    sId = json['_id'];
    company = json['company'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = location!.toJson();
    data['_id'] = sId;
    data['company'] = company;
    data['name'] = name;
    return data;
  }
}

class OfficeLocation {
  String? type;
  List<double>? coordinates;
  String? address;
  String? landmark;
  String? placeId;

  OfficeLocation({
    this.type,
    this.coordinates,
    this.address,
    this.landmark,
    this.placeId,
  });

  OfficeLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
    address = json['address'];
    landmark = json['landmark'] ?? '';
    placeId = json['place_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    data['address'] = address;
    data['landmark'] = landmark;
    data['place_id'] = placeId;
    return data;
  }
}
