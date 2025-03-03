import 'package:flutter/material.dart';
import '../widgets/address_card.dart';

class AddressChangeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request Address Change',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black54,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   padding: const EdgeInsets.all(12),
              //   decoration: BoxDecoration(
              //     color: Colors.deepOrange.shade50,
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       const Icon(
              //         Icons.info_outline,
              //         color: Colors.deepOrangeAccent,
              //         size: 16,
              //       ),
              //       const SizedBox(width: 8),
              //       Expanded(
              //         child: Text(
              //           "You have 1 request left till 2nd Mar, to change your address",
              //           style: TextStyle(
              //               color: Colors.deepOrange.shade900, fontSize: 11),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 16),
              AddressCard(
                title: "Primary Address",
                address:
                    "Manbhum - Around the Grove, White Field Rd, Ashok Nagar, Whitefields, Kondapur, Telangana 500081, India",
                geocode: "17.452898, 78.367304",
                shuttleStop: "-- --",
              ),
              const SizedBox(height: 16),
              AddressCard(
                title: "Secondary Address",
                address: "IN_HYD_OMGB",
                geocode: "17.457919, 78.371856",
                shuttleStop: "-- --",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
