import 'package:flutter/material.dart';

class ProfileImageViewer extends StatelessWidget {
  final String imageUrl;
  const ProfileImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // يجعل الخلفية شفافة
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Hero(
            tag: imageUrl,
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: ClipOval(
                child: Image.network(imageUrl, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
