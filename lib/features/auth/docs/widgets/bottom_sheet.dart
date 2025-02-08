import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rideinsync_client/models/document_model.dart';

import '../controllers/document_controller.dart';

Widget bottomSheet(RequiredDocs doc) {
  final controller = Get.put(DocumentController());

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // ListTile(
      //   leading: const Icon(Icons.camera_alt),
      //   title: const Text(
      //     'Camera',
      //   ),
      //   onTap: () async {
      //     String name = await pickImage(ImageSource.camera);
      //     if (name != "") {
      //       uploadDoc(id);
      //     }
      //   },
      // ),
      ListTile(
        leading: const Icon(Icons.image),
        title: const Text(
          'Gallery',
        ),
        onTap: () {
          controller.pickImage(ImageSource.gallery, doc);
        },
      )
    ],
  );
}
