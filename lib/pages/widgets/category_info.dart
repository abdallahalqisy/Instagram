import 'package:flutter/material.dart';
import 'package:simpleinstagram/pages/widgets/button_card.dart';
import 'package:simpleinstagram/pages/widgets/custom_text.dart';

class CategoryInfo extends StatelessWidget {
  const CategoryInfo({
    super.key,
    required this.img,
    required this.category,
    required this.url,
  });
  final List img;
  final String category;
  final String url;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: category,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            Transform.rotate(angle: -10, child: Icon(Icons.link)),
            const SizedBox(width: 8),
            CustomText(text: url, fontWeight: FontWeight.w600),
          ],
        ),

        const SizedBox(height: 9),
        Row(
          children: [
            SizedBox(
              height: 40,
              width: (img.length * 27.0) + 10,
              child: Stack(
                children: [
                  for (var i = 0; i < img.length; i++)
                    Positioned(
                      left: i * 22,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 19,
                          backgroundImage: NetworkImage(img[i]),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 250,
              child: CustomText(
                text: 'Followed by abdallah, mohamed, ahmed ,and 3 others...',
                fontSize: 12,
                color: Colors.grey,
                maxLines: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        ButtonCard(),
      ],
    );
  }
}
