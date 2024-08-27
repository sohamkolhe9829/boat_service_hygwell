import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// ignore: must_be_immutable
class AvailableBoatCard extends StatelessWidget {
  String title;
  String subtitle;
  double price;
  List<dynamic> imageUrls;
  int seats;
  AvailableBoatCard({
    super.key,
    required this.imageUrls,
    required this.subtitle,
    required this.price,
    required this.title,
    required this.seats,
  });

  @override
  Widget build(BuildContext context) {
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
                itemCount: imageUrls.length,
                itemBuilder: (context, itemIndex, pageViewIndex) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: imageUrls[itemIndex],
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
                  aspectRatio: 16 / 9,
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 15,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 20,
                    ),
                    Text(
                      "\t\t$seats seats",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800]),
        ),
        Text(
          "₹ ${price.toInt()} / Adult",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
