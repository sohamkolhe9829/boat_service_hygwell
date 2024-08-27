import 'package:boat_service_hygwell/screens/passenger_detail_screen.dart';
import 'package:boat_service_hygwell/widgets/custom_button.dart';
import 'package:boat_service_hygwell/widgets/dash_divider.dart';
import 'package:boat_service_hygwell/widgets/info_bullet_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BoatInfoScreen extends StatelessWidget {
  String docId;
  BoatInfoScreen({super.key, required this.docId});

  @override
  Widget build(BuildContext context) {
    // List imageUrls = [
    //   "https://firebasestorage.googleapis.com/v0/b/boat-service-hygwell.appspot.com/o/img1.jpeg?alt=media&token=2a5cb430-0753-4f4f-8de0-b3550f6ca095",
    //   "https://firebasestorage.googleapis.com/v0/b/boat-service-hygwell.appspot.com/o/img2.jpeg?alt=media&token=e3d2ed3e-4f3c-43e7-9dc9-e28e39fd2f19",
    //   "https://firebasestorage.googleapis.com/v0/b/boat-service-hygwell.appspot.com/o/img3.jpeg?alt=media&token=2926e216-db62-4e67-a178-6ac5aa0fb888",
    //   "https://firebasestorage.googleapis.com/v0/b/boat-service-hygwell.appspot.com/o/img4.jpeg?alt=media&token=d025aed1-dd77-4f20-92ef-69aba7868a47",
    // ];
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
              final images = snapshot.data!.get('images');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CarouselSlider.builder(
                          itemCount: images.length,
                          itemBuilder: (context, itemIndex, pageViewIndex) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: images[itemIndex],
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            scrollPhysics: const ScrollPhysics(
                              parent: BouncingScrollPhysics(),
                            ),
                            aspectRatio: 1 / 1,
                          ),
                        ),
                      ),
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
                      Positioned(
                        right: 20,
                        top: 50,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.share,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.get('name'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          snapshot.data!.get('description'),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Wed, Jun20 - ${snapshot.data!.get('capacity')} Passengers",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const DashDivider(
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 10),
                        InfoBulletWidget(
                          title: "Amenities",
                          content: snapshot.data!.get('amenities'),
                        ),
                        const SizedBox(height: 10),
                        const DashDivider(
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 10),
                        InfoBulletWidget(
                          title: "Safety Features",
                          content: snapshot.data!.get('safetyFeatures'),
                        ),
                        const SizedBox(height: 10),
                        const DashDivider(
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 10),
                        InfoBulletWidget(
                          title: "Special Notes",
                          content: const [
                            "Please arrive 30 minutes before departure.",
                          ],
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          title: "Go to passenger details",
                          callBack: () {
                            print("Called");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PassengerDetailScreen(
                                  docId: docId,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
