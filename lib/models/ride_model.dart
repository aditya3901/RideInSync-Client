class RideModel {
  final String id;
  final String user;
  final String driver;
  final String office;
  final String timeslot;
  final DateTime date;
  final String type;
  final Location rideStartLocation;
  final Location rideEndLocation;
  final String status;
  final double distance;
  final double duration;
  final double rating;

  RideModel({
    required this.id,
    required this.user,
    required this.driver,
    required this.office,
    required this.timeslot,
    required this.date,
    required this.type,
    required this.rideStartLocation,
    required this.rideEndLocation,
    required this.status,
    required this.distance,
    required this.duration,
    required this.rating,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      driver: json['driver'] ?? '',
      office: json['office'] ?? '',
      timeslot: json['timeslot'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      type: json['type'] ?? '',
      rideStartLocation: Location.fromJson(json['ride_start_location'] ?? {}),
      rideEndLocation: Location.fromJson(json['ride_end_location'] ?? {}),
      status: json['status'] ?? '',
      distance: (json['distance'] ?? 0).toDouble(),
      duration: (json['duration'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'driver': driver,
      'office': office,
      'timeslot': timeslot,
      'date': date.toIso8601String(),
      'type': type,
      'ride_start_location': rideStartLocation.toJson(),
      'ride_end_location': rideEndLocation.toJson(),
      'status': status,
      'distance': distance,
      'duration': duration,
      'rating': rating,
    };
  }
}

class Location {
  final String type;
  final List<double> coordinates;
  final String address;
  final String landmark;
  final String placeId;
  final String id;

  Location({
    required this.type,
    required this.coordinates,
    required this.address,
    required this.landmark,
    required this.placeId,
    required this.id,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: List<double>.from(json['coordinates'] ?? []),
      address: json['address'] ?? '',
      landmark: json['landmark'] ?? '',
      placeId: json['place_id'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
      'address': address,
      'landmark': landmark,
      'place_id': placeId,
      '_id': id,
    };
  }
}
