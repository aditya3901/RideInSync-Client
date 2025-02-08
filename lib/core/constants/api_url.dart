class ApiUrl {
  static const String baseUrl = 'https://rideinsync-gateway.onrender.com';
  // static const String baseUrl = 'http://192.168.29.10:3000';

  // Common Endpoints
  static const String cloudinaryUpload =
      'https://api.cloudinary.com/v1_1/dczqdfqhy/upload';
  static const String verifyEmail = '$baseUrl/auth/common/verifyEmail';

  // User Endpoints
  static const String userRegister = '$baseUrl/auth/user/register';
  static const String userLogin = '$baseUrl/auth/user/login';
  static const String userLogout = '$baseUrl/auth/user/logout';
  static const String userGetDocs = '$baseUrl/auth/user/getDocs';
  static const String userUploadDocs = '$baseUrl/auth/user/uploadDocs';
  static const String userDetails = '$baseUrl/auth/user/details';

  // Driver Endpoints
  static const String driverRegister = '$baseUrl/auth/driver/register';
  static const String driverLogin = '$baseUrl/auth/driver/login';
  static const String driverLogout = '$baseUrl/auth/driver/logout';
  static const String driverGetDocs = '$baseUrl/auth/driver/getDocs';
  static const String driverUploadDocs = '$baseUrl/auth/driver/uploadDocs';
  static const String driverDetails = '$baseUrl/auth/driver/details';
}
