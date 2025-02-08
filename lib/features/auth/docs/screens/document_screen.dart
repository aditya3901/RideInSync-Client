import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rideinsync_client/features/auth/docs/controllers/document_controller.dart';
import 'package:rideinsync_client/features/auth/docs/widgets/file_layout.dart';

class DocumentScreen extends StatefulWidget {
  final String userType;

  const DocumentScreen({Key? key, required this.userType}) : super(key: key);

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final _controller = Get.put(DocumentController());

  @override
  void initState() {
    super.initState();
    _controller.fetchDocuments(widget.userType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: _controller.isLoading.value,
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Upload documents",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const Text(
                    "Add the required documents listed below to\ncomplete your registration.",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 30),
                  _controller.documentModel.value == null
                      ? Container()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _controller
                              .documentModel.value!.requiredDocs!.length,
                          itemBuilder: (context, index) {
                            return fileLayout(
                              _controller
                                  .documentModel.value!.requiredDocs![index],
                            );
                          },
                        ),
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.deepOrangeAccent, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.watch_later_outlined,
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Verification will be completed within 24 hours",
                            style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepOrangeAccent,
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
