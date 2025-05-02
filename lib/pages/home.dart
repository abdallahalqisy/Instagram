import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simpleinstagram/pages/user.dart';
import 'package:simpleinstagram/pages/widgets/custom_text.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();
  Map info = {};
  bool isLoading = false;
  // get mathod to get user data from the API
  Future<void> getInfo() async {
    setState(() {
      isLoading = true;
    });
    final uri =
        'https://instagram-social-api.p.rapidapi.com/v1/info?username_or_id_or_url=${controller.text}';
    final url = Uri.parse(uri);
    final response = await http.get(
      url,
      headers: {
        'x-rapidapi-key': '2b404bec39mshbde2af8e3242a58p1f24e7jsn5281317c8493',
        'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com',
      },
    );
    final json = jsonDecode(response.body) as Map;
    final result = json['data'] != null ? json['data'] as Map : {};
    setState(() {
      info = result;
      isLoading = false;
    });
    if (response.statusCode == 200) {
      navigateToUserPage(info);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User data fetched successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch user data!')),
      );
    }
    print(response.body);
  }

  void navigateToUserPage(Map info) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => User(info: info)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Center(
                child: Icon(
                  Ionicons.logo_instagram,
                  size: 100,
                  color: Colors.pinkAccent,
                ),
              ),
              const SizedBox(height: 20),
              CustomText(text: 'Enter User Name'),
              const SizedBox(height: 20),

              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.pinkAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.pinkAccent),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    getInfo();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(
                    child:
                        isLoading
                            ? const CupertinoActivityIndicator(
                              color: Colors.black,
                            )
                            : CustomText(text: 'Continue', color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
