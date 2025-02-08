import 'package:flutter/material.dart';

Widget phoneInputField(
  String label,
  TextInputType inputType,
  TextEditingController? controller,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: TextFormField(
      controller: controller,
      style: const TextStyle(
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12, width: 2.0),
          borderRadius: BorderRadius.circular(6),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12, width: 2.0),
          borderRadius: BorderRadius.circular(6),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 18,
          color: Color(0xFF999FB7),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
        ),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(width: 12),
            Text(
              "+91",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
      ),
      keyboardType: inputType,
    ),
  );
}
