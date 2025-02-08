class DriverModel {
  String? type;
  String? token;
  Driver? driver;

  DriverModel({this.type, this.token, this.driver});

  DriverModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    token = json['token'];
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['token'] = token;
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    return data;
  }
}

class Driver {
  String? name;
  String? mobile;
  String? email;
  bool? online;
  bool? verified;
  String? vehicleNumber;
  String? vehicleModel;
  int? rating;
  int? totalRides;
  String? deviceId;
  String? deviceType;
  String? deviceToken;
  Location? location;

  Driver(
      {this.name,
      this.mobile,
      this.email,
      this.online,
      this.verified,
      this.vehicleNumber,
      this.vehicleModel,
      this.rating,
      this.totalRides,
      this.deviceId,
      this.deviceType,
      this.deviceToken,
      this.location});

  Driver.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    online = json['online'];
    verified = json['verified'];
    vehicleNumber = json['vehicle_number'];
    vehicleModel = json['vehicle_model'];
    rating = json['rating'];
    totalRides = json['total_rides'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    location =
        (json['location'] != null && json['location']['coordinates'] != null)
            ? Location.fromJson(json['location'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['online'] = online;
    data['verified'] = verified;
    data['vehicle_number'] = vehicleNumber;
    data['vehicle_model'] = vehicleModel;
    data['rating'] = rating;
    data['total_rides'] = totalRides;
    data['device_id'] = deviceId;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    if (location != null) {
      data['location'] = location!.toJson();
    }
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
