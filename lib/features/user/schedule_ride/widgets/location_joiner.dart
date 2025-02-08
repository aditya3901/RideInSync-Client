import 'package:flutter/material.dart';

class LocationJoiner extends StatelessWidget {
  final String fromAddress;
  final String toAddress;
  const LocationJoiner(
      {Key? key, required this.fromAddress, required this.toAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.location_on, color: Colors.green),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "502, Jagmagia Apartment, Rishav CHS, Off Link Road, Malad West, Mumbai, Maharashtra 400064",
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            children: List.generate(
              4,
              (index) => Container(
                width: 2,
                height: 5,
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(vertical: 2),
              ),
            ),
          ),
        ),
        Row(
          children: const [
            Icon(Icons.location_on, color: Colors.red),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "Malad Interface 16, Interface Road, Malad West, Mumbai, Maharashtra 400064",
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ],
    );
  }
}
