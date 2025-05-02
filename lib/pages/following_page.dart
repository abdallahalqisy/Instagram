import 'package:flutter/material.dart';
import 'package:simpleinstagram/pages/widgets/custom_text.dart';

class FollowingsPage extends StatelessWidget {
  const FollowingsPage({
    super.key,
    required this.following,
    required this.userName,
  });

  final List following;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(userName)),
      body: ListView.builder(
        itemCount: following.length,
        itemBuilder: (context, index) {
          final follower = following[index];
          final image = follower['profile_pic_url'] ?? '';
          final name = follower['full_name'] ?? 'No Name';
          final username = follower['username'] ?? '';

          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(image)),
            title: CustomText(text: name),
            subtitle: CustomText(text: username),
          );
        },
      ),
    );
  }
}
