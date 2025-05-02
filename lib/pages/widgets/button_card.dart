import 'package:flutter/material.dart';
import 'package:simpleinstagram/pages/widgets/custom_text.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                CustomText(text: 'Following', fontWeight: FontWeight.bold),
                Icon(Icons.keyboard_arrow_down_sharp),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                CustomText(text: 'Message', fontWeight: FontWeight.bold),
              ],
            ),
          ),
          const SizedBox(width: 15),

          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [Icon(Icons.person_add_alt_1_outlined)]),
          ),
        ],
      ),
    );
  }
}
