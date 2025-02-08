import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/models/document_model.dart';
import 'package:rideinsync_client/models/driver_model.dart';
import 'package:rideinsync_client/models/user_model.dart';
import 'package:rideinsync_client/services/cloudinary_service.dart';
import 'package:rideinsync_client/services/common_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentController extends GetxController {
  var documentModel = Rx<DocumentModel?>(null);
  var isLoading = true.obs;
  dynamic currentUser;
  File? pickedFile;

  final _authService = locator<CommonAuthService>();
  final _cloudinaryService = locator<CloudinaryService>();

  Future<void> fetchDocuments(String userType) async {
    isLoading.value = true;

    final prefs = await SharedPreferences.getInstance();
    if (userType == 'user') {
      currentUser = UserModel.fromJson(
        jsonDecode(prefs.getString("user")!),
      );
    } else {
      currentUser = DriverModel.fromJson(
        jsonDecode(prefs.getString("driver")!),
      );
    }

    final documentResponse = await _authService.getDocs(
      userType,
      currentUser.token,
    );

    documentModel.value = DocumentModel.fromJson(documentResponse);

    isLoading.value = false;
  }

  Future<void> pickImage(ImageSource source, RequiredDocs doc) async {
    isLoading.value = true;

    final image = await ImagePicker().pickImage(
      source: source,
    );
    if (image == null) {
      isLoading.value = false;
      Get.snackbar("No file chosen", "Please select a file");
      return;
    }

    pickedFile = File(image.path);

    uploadDocument(pickedFile!.path, doc);
  }

  Future<void> uploadDocument(String path, RequiredDocs doc) async {
    final uploadedData = await _cloudinaryService.uploadImage(path);
    final secureUrl = uploadedData['secure_url'];

    await _authService.uploadDocs(
      currentUser.type,
      currentUser.token,
      doc.sId!,
      secureUrl,
    );

    fetchDocuments(currentUser.type);
  }
}
