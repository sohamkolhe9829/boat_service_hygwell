import 'package:boat_service_hygwell/screens/add_on_screen.dart';
import 'package:boat_service_hygwell/widgets/custom_button.dart';
import 'package:boat_service_hygwell/widgets/dash_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../widgets/passenger_detail_overlay.dart';

class PassengerDetailScreen extends StatelessWidget {
  String docId;
  PassengerDetailScreen({super.key, required this.docId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('boats')
                .doc(docId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.hasError) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              return Column(
                children: [
                  Stack(
                    children: [
                      //Upper overlay conatiner
                      Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width,
                        color: HexColor("#B5D3F5"),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height / 3 + 20,
                            ),
                            const SizedBox(height: 30),
                            //Contact Card
                            const PassengerDetailContact(),
                            const SizedBox(height: 20),
                            //Passenger detail card
                            const PassengerDetailCard(),
                            const SizedBox(height: 30),
                            //Button for navigation
                            CustomButton(
                                title: "Continue",
                                callBack: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddOnScreen(
                                        docId: docId,
                                      ),
                                    ),
                                  );
                                }),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                      //Overlay data
                      Positioned(
                        left: 20,
                        top: 50,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      //Overlay Card Widget
                      PassengerDetailOverlay(
                        title: snapshot.data!.get('name'),
                        capacity: snapshot.data!.get('capacity'),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class PassengerDetailContact extends StatelessWidget {
  const PassengerDetailContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: HexColor("#FF6666"),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Your ticket information will be sent on this number",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              const Text(
                "91911234589",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Text(
                  "Edit",
                  style: TextStyle(
                    color: HexColor("#FF6666"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PassengerDetailCard extends StatefulWidget {
  const PassengerDetailCard({super.key});

  @override
  State<PassengerDetailCard> createState() => _PassengerDetailCardState();
}

class _PassengerDetailCardState extends State<PassengerDetailCard> {
  String gender = "Select";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Passenger Details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Passenger 1",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Enter Full Name",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "Enter your name",
            ),
          ),
          Text(
            "Enter name as per Aadhar",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: HexColor("#A4A0BB"),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter your age",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Enter your age",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gender",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[600]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: DropdownButton(
                          value: gender,
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: const Text("Male"),
                          items: const [
                            DropdownMenuItem(
                              value: "Select",
                              child: Text("Select"),
                            ),
                            DropdownMenuItem(
                              value: "Male",
                              child: Text("Male"),
                            ),
                            DropdownMenuItem(
                              value: "Female",
                              child: Text("Female"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const DashDivider(
            color: Colors.grey,
          ),
          const SizedBox(height: 30),
          const Text(
            "Passenger 2",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Enter Full Name",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "Enter your name",
            ),
          ),
          Text(
            "Enter name as per Aadhar",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: HexColor("#A4A0BB"),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter your age",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Enter your age",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gender",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[600]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: DropdownButton(
                          value: gender,
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: const Text("Male"),
                          items: const [
                            DropdownMenuItem(
                              value: "Select",
                              child: Text("Select"),
                            ),
                            DropdownMenuItem(
                              value: "Male",
                              child: Text("Male"),
                            ),
                            DropdownMenuItem(
                              value: "Female",
                              child: Text("Female"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
