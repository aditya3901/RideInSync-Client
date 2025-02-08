import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rideinsync_client/core/constants/api_url.dart';

class CloudinaryService {
  Future<Map<String, dynamic>> uploadImage(String path) async {
    final request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.cloudinaryUpload))
          ..fields['upload_preset'] = 'rideinsync'
          ..files.add(
            await http.MultipartFile.fromPath(
              'file',
              path,
            ),
          );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    return jsonDecode(responseBody);
  }
}
