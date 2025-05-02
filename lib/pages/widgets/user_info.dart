import 'package:flutter/material.dart';
import 'package:simpleinstagram/pages/widgets/custom_text.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.userImg,
    required this.folowersNumber,
    required this.followingNumbers,
    this.onTap,
    required this.postCount,
    required this.onTapFollowers,
    required this.followingOntap,
  });
  final String userImg, folowersNumber, followingNumbers;
  final void Function()? onTap;
  final void Function() onTapFollowers;
  final void Function() followingOntap;

  final String postCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.pinkAccent,
                  Colors.pinkAccent,
                  Colors.orangeAccent,
                ],
              ),
            ),

            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(userImg),
            ),
          ),
        ),
        const SizedBox(width: 30),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: postCount, fontWeight: FontWeight.bold),
            CustomText(text: 'posts', color: Colors.grey),
          ],
        ),
        const SizedBox(width: 30),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onTapFollowers,
              child: CustomText(
                text: folowersNumber,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomText(text: 'Followes', color: Colors.grey),
          ],
        ),
        const SizedBox(width: 30),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: followingOntap,
              child: CustomText(
                text: followingNumbers,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomText(text: 'Following', color: Colors.grey),
          ],
        ),
      ],
    );
  }
}
