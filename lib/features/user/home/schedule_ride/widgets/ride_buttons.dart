import 'package:flutter/material.dart';

class RideButtons extends StatelessWidget {
  const RideButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Material(
            color: Colors.grey[200],
            child: InkWell(
              splashColor: Colors.white,
              onTap: () {},
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.close_rounded,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ClipOval(
          child: Material(
            color: Colors.grey[200],
            child: InkWell(
              splashColor: Colors.white,
              onTap: () {},
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.edit_rounded,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Colors.grey[300],
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Track",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
