import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rideinsync_client/core/constants/api_url.dart';

class CommonAuthService {
  Future<Map<String, dynamic>> verifyEmail(String email) async {
    final response = await http.post(
      Uri.parse(ApiUrl.verifyEmail),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email}),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getCompanies() async {
    final response = await http.get(
      Uri.parse(ApiUrl.getCompanies),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> register(
    String type,
    Map<String, dynamic> reqBody,
  ) async {
    String endpoint;
    if (type == 'user') {
      endpoint = ApiUrl.userRegister;
    } else {
      endpoint = ApiUrl.driverRegister;
    }

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(reqBody),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> login(
    String type,
    Map<String, dynamic> reqBody,
  ) async {
    String endpoint;
    if (type == 'user') {
      endpoint = ApiUrl.userLogin;
    } else {
      endpoint = ApiUrl.driverLogin;
    }

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(reqBody),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getDocs(String userType, String token) async {
    String endpoint;
    if (userType == 'user') {
      endpoint = ApiUrl.userGetDocs;
    } else {
      endpoint = ApiUrl.driverGetDocs;
    }

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    final decodedResponse = jsonDecode(response.body);
    return decodedResponse['data'];
  }

  Future<Map<String, dynamic>> getDetails(String type, String token) async {
    String endpoint;
    if (type == 'user') {
      endpoint = ApiUrl.userDetails;
    } else {
      endpoint = ApiUrl.driverDetails;
    }

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    final decodedResponse = jsonDecode(response.body);
    return type == 'user' ? decodedResponse['user'] : decodedResponse['driver'];
  }

  Future<Map<String, dynamic>> uploadDocs(
    String userType,
    String token,
    String docId,
    String url,
  ) async {
    String endpoint;
    if (userType == 'user') {
      endpoint = ApiUrl.userUploadDocs;
    } else {
      endpoint = ApiUrl.driverUploadDocs;
    }

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'docId': docId, 'file': url}),
    );

    return jsonDecode(response.body);
  }
}
