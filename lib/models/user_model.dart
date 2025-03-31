class UserModel {
  String? type;
  String? token;
  User? user;

  UserModel({this.type, this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? mobile;
  String? company;
  String? deviceId;
  String? deviceType;
  String? deviceToken;
  Location? primaryAddress;
  Location? secondaryAddress;
  bool? verified;

  User({
    this.name,
    this.email,
    this.mobile,
    this.company,
    this.deviceId,
    this.deviceType,
    this.deviceToken,
    this.primaryAddress,
    this.secondaryAddress,
    this.verified,
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    company = json['company'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    primaryAddress = (json['primary_address'] != null)
        ? Location.fromJson(json['primary_address'])
        : null;
    secondaryAddress = (json['secondary_address'] != null)
        ? Location.fromJson(json['secondary_address'])
        : null;
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['company'] = company;
    data['device_id'] = deviceId;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    if (primaryAddress != null) {
      data['primary_address'] = primaryAddress!.toJson();
    }
    if (secondaryAddress != null) {
      data['secondary_address'] = secondaryAddress!.toJson();
    }
    data['verified'] = verified;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;
  String? address;
  String? landmark;
  String? placeId;

  Location({
    this.type,
    this.coordinates,
    this.address,
    this.landmark,
    this.placeId,
  });

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
    address = json['address'];
    landmark = json['landmark'];
    placeId = json['place_id'];
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
