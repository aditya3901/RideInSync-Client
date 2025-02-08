import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/features/auth/docs/widgets/bottom_sheet.dart';
import 'package:rideinsync_client/models/document_model.dart';

Widget fileLayout(RequiredDocs doc) {
  return InkWell(
    onTap: () {
      if (doc.uploaded == false) {
        showModalBottomSheet(
          context: Get.context!,
          builder: (_) => bottomSheet(doc),
        );
      }
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            (doc.uploaded ?? false)
                ? Icons.done_all
                : Icons.file_present_outlined,
            color: (doc.uploaded ?? false) ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              doc.name ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    ),
  );
}
