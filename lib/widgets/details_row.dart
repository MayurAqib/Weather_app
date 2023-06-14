import 'package:flutter/material.dart';

import '../theme/colors.dart';

class DetailRow extends StatelessWidget {
  const DetailRow(
      {super.key, required this.heading, required this.weatherDetails});
  final String heading;
  final String weatherDetails;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$heading:',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 18, color: textColor),
          ),
          Text(
            weatherDetails,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          )
        ],
      ),
    );
  }
}
