import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  final String image;
  final String label;
  final String description;
  const WelcomeCard(
      {Key? key,
      required this.image,
      required this.label,
      required this.description})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    const double imageWidth = 250;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25, bottom: 35),
          child: Image.asset(
            image,
            width: imageWidth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25.0, bottom: 10),
          child: Text(
            label,
            style:
                TextStyle(height: 2, fontWeight: FontWeight.bold, fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 35, left: 35),
          child: Text(
            description,
            style: TextStyle(
                height: 2, fontWeight: FontWeight.bold, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
