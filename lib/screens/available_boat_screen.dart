import 'package:boat_service_hygwell/screens/boat_info_screen.dart';
import 'package:boat_service_hygwell/widgets/available_boat_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AvailableBoatScreen extends StatelessWidget {
  const AvailableBoatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Boarding point",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              "Wed, Jun 20 - 2 passengers",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white,
                )),
            child: const Text(
              "Modify",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('boats').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.hasError) {
                return const CircularProgressIndicator();
              }

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: const Text(
                      "Showing Available boats",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        // itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = snapshot.data!.docs[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BoatInfoScreen(
                                    docId: data.id,
                                  ),
                                ),
                              );
                            },
                            child: AvailableBoatCard(
                              // imageUrls: [

                              //   // "https://firebasestorage.googleapis.com/v0/b/boat-service-hygwell.appspot.com/o/img1.jpeg?alt=media&token=2a5cb430-0753-4f4f-8de0-b3550f6ca095",
                              //   // "https://firebasestorage.googleapis.com/v0/b/boat-service-hygwell.appspot.com/o/img2.jpeg?alt=media&token=e3d2ed3e-4f3c-43e7-9dc9-e28e39fd2f19",
                              //   // "https://firebasestorage.googleapis.com/v0/b/boat-service-hygwell.appspot.com/o/img3.jpeg?alt=media&token=2926e216-db62-4e67-a178-6ac5aa0fb888",
                              //   // "https://firebasestorage.googleapis.com/v0/b/boat-service-hygwell.appspot.com/o/img4.jpeg?alt=media&token=d025aed1-dd77-4f20-92ef-69aba7868a47",
                              // ],
                              imageUrls: data.get('images'),
                              subtitle:
                                  "Trip start by 7:10 AM from Hills & journey ends by around 1:00 AM.",
                              price: 1500,
                              title: data.get('name'),
                              seats: int.parse(data.get('capacity')),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
