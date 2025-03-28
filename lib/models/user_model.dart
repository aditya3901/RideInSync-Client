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
  Location? location;
  bool? verified;

  User(
      {this.name,
      this.email,
      this.mobile,
      this.company,
      this.deviceId,
      this.deviceType,
      this.deviceToken,
      this.location,
      this.verified});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    company = json['company'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    location =
        (json['location'] != null && json['location']['coordinates'] != null)
            ? Location.fromJson(json['location'])
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
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['verified'] = verified;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
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
