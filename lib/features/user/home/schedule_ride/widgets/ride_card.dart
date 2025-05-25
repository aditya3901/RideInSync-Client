import 'package:flutter/material.dart';
import 'package:rideinsync_client/models/ride_model.dart';
import './location_joiner.dart';
import './ride_buttons.dart';

class RideCard extends StatefulWidget {
  final RideModel ride;
  const RideCard({Key? key, required this.ride}) : super(key: key);

  @override
  State<RideCard> createState() => _RideCardState();
}

class _RideCardState extends State<RideCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.login, color: Colors.black54),
                      const SizedBox(width: 4),
                      Text(
                        widget.ride.type.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "10:30",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Spacer(),
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(Icons.keyboard_arrow_down,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 4),
                      Icon(
                        Icons.timer_rounded,
                        color: Colors.deepPurple[300],
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.ride.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.deepPurple[300],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LocationJoiner(
                      fromAddress: widget.ride.rideStartLocation.address,
                      toAddress: widget.ride.rideEndLocation.address,
                    ),
                    const SizedBox(height: 20),
                    RideButtons(),
                  ],
                ),
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
          ],
        ),
      ),
    );
  }
}
