import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoBulletWidget extends StatelessWidget {
  String title;
  List content;
  InfoBulletWidget({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(left: 20),
          itemCount: content.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: const Icon(
                Icons.circle,
                size: 10,
              ),
              minVerticalPadding: 0,
              title: Text(
                content[index],
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            );
            // return Row(
            //   children: [
            //     const Icon(
            //       Icons.circle,
            //       size: 10,
            //     ),
            //     const SizedBox(width: 10),
            //     Text(
            //       content[index],

            //       style: const TextStyle(
            //         fontSize: 20,
            //       ),
            //     ),
            //   ],
            // );
          },
        ),
      ],
    );
  }
}
