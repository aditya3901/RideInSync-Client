import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrl {
  // static const String baseUrl = 'https://rideinsync-gateway.onrender.com';
  static const String baseUrl = 'http://192.168.29.89:3000';

  // Common Endpoints
  static final String cloudinaryUpload =
      'https://api.cloudinary.com/v1_1/${dotenv.env['CLOUDINARY_API_KEY']}/upload';

  static final String googleAutoComplete =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=${dotenv.env['GOOGLE_PLACES_API_KEY']}&input=';
  static final String googlePlaceDetails =
      'https://maps.googleapis.com/maps/api/place/details/json?key=${dotenv.env['GOOGLE_PLACES_API_KEY']}&place_id=';
  static final String googleGeocode =
      'https://maps.googleapis.com/maps/api/geocode/json?key=${dotenv.env['GOOGLE_PLACES_API_KEY']}&result_type=street_address&location_type=ROOFTOP&latlng=';

  static const String verifyEmail = '$baseUrl/auth/common/verify-email';
  static const String getCompanies = '$baseUrl/admin/company';
  static const String getOffices = '$baseUrl/admin/office/nearby';
  static const String getTimeslots = '$baseUrl/admin/timeslots';
  static const String bookRide = '$baseUrl/booking/rides';
  static const String getRides = '$baseUrl/booking/rides/user/upcoming';

  // User Endpoints
  static const String userRegister = '$baseUrl/auth/user/register';
  static const String userLogin = '$baseUrl/auth/user/login';
  static const String userLogout = '$baseUrl/auth/user/logout';
  static const String userGetDocs = '$baseUrl/auth/user/docs/required';
  static const String userUploadDocs = '$baseUrl/auth/user/docs/upload';
  static const String userDetails = '$baseUrl/auth/user/details';
  static const String userAddress = '$baseUrl/auth/user/address';

  // Driver Endpoints
  static const String driverRegister = '$baseUrl/auth/driver/register';
  static const String driverLogin = '$baseUrl/auth/driver/login';
  static const String driverLogout = '$baseUrl/auth/driver/logout';
  static const String driverGetDocs = '$baseUrl/auth/driver/docs/required';
  static const String driverUploadDocs = '$baseUrl/auth/driver/docs/upload';
  static const String driverDetails = '$baseUrl/auth/driver/details';
}
