import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simpleinstagram/pages/home.dart';

void main() {
  runApp(const MyApp());
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const Center(child: CupertinoActivityIndicator(color: Colors.white));
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Flutter Demo',
      home: const Home(),
    );
  }
}
