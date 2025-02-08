import 'package:flutter/material.dart';

Widget inputField(
  String label,
  TextInputType inputType,
  TextEditingController? controller,
) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: TextFormField(
      controller: controller,
      style: const TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 16,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
        ),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(width: 16),
            Icon(
              Icons.person_outline,
              color: Colors.deepOrangeAccent,
            ),
            SizedBox(width: 12),
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
