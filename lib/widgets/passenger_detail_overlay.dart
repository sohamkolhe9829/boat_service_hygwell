import 'package:boat_service_hygwell/widgets/dash_divider.dart';
import 'package:flutter/material.dart';

class PassengerDetailOverlay extends StatelessWidget {
  String title;
  String capacity;
  PassengerDetailOverlay(
      {super.key, required this.title, required this.capacity});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 3 - 180,
      left: 15,
      right: 15,
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "7:00 AM",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "From",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: DashDivider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        height: 20,
                        child: Image.asset('assets/icon/cruise_icon.png'),
                      ),
                    ),
                    const Expanded(
                      child: DashDivider(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "3:00 PM",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "To",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const DashDivider(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 30,
                    ),
                    Text(
                      "\t\t$capacity seats",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
