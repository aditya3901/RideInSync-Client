import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rideinsync_client/core/constants/api_url.dart';

class BookingService {
  Future<Map<String, dynamic>> getNearbyOffice({
    required String companyId,
    required double latitude,
    required double longitude,
    String? maxDistance,
  }) async {
    final response = await http.get(
      Uri.parse(
        "${ApiUrl.getOffices}?company_id=$companyId&latitude=$latitude&longitude=$longitude&maxDistance=50000",
      ),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getNextTimeslots({
    required String date,
    required String officeId,
    required String type,
    required String userTime,
  }) async {
    final response = await http.get(
      Uri.parse(
        "${ApiUrl.getTimeslots}?date=$date&office_id=$officeId&type=$type&userTime=$userTime",
      ),
    );

    return jsonDecode(response.body);
  }
}
