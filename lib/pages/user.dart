import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simpleinstagram/pages/followers_page.dart';
import 'package:simpleinstagram/pages/following_page.dart';
import 'package:simpleinstagram/pages/profile_image_viewer.dart';
import 'package:simpleinstagram/pages/video.dart';
import 'package:simpleinstagram/pages/widgets/category_info.dart';
import 'package:simpleinstagram/pages/widgets/custom_text.dart';
import 'package:simpleinstagram/pages/widgets/user_info.dart';

class User extends StatefulWidget {
  const User({super.key, required this.info});
  final Map info;
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List posts = [];
  List followers = [];
  List folowing = [];
  List reals = [];
  List tagged = [];

  @override
  void initState() {
    getTagged();
    getReals();
    getPosts();
    getFollowing();
    getFollowers();
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> getPosts() async {
    final uri =
        'https://instagram-social-api.p.rapidapi.com/v1/posts?username_or_id_or_url=${widget.info['username']}'; // Replace with your API URL
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com',
        'x-rapidapi-key': '2b404bec39mshbde2af8e3242a58p1f24e7jsn5281317c8493',
      },
    );
    final json = jsonDecode(response.body) as Map;
    final result =
        json['data']['items']
            as List; // Adjust this based on your API response structure
    setState(() {
      posts = result;
      print('Number of posts: ${posts.length}');
    });
  }

  Future<void> getTagged() async {
    final uri =
        'https://instagram-social-api.p.rapidapi.com/v1/tagged?username_or_id_or_url=${widget.info['username']}'; // Replace with your API URL
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com',
        'x-rapidapi-key': '2b404bec39mshbde2af8e3242a58p1f24e7jsn5281317c8493',
      },
    );
    final json = jsonDecode(response.body) as Map;
    final result =
        json['data']['items']
            as List; // Adjust this based on your API response structure
    setState(() {
      tagged = result;
      print('Number of posts: ${posts.length}');
    });
  }

  Future<void> getReals() async {
    final uri =
        'https://instagram-social-api.p.rapidapi.com/v1/search_reels?search_query=${widget.info['username']}'; // Replace with your API URL
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com',
        'x-rapidapi-key': '2b404bec39mshbde2af8e3242a58p1f24e7jsn5281317c8493',
      },
    );
    final json = jsonDecode(response.body) as Map;
    final result = json['data']['items'] as List;

    // Adjust this based on your API response structure
    setState(() {
      reals = result;

      print('Number of reals: ${reals.length}');
    });
  }

  Future<void> getFollowers() async {
    final uri =
        'https://instagram-social-api.p.rapidapi.com/v1/followers?username_or_id_or_url=${widget.info['username']}'; // Replace with your API URL
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com',
        'x-rapidapi-key': '2b404bec39mshbde2af8e3242a58p1f24e7jsn5281317c8493',
      },
    );
    final json = jsonDecode(response.body) as Map;
    final result =
        json['data']['items']
            as List; // Adjust this based on your API response structure
    setState(() {
      followers = result;
      print('Number of followers: ${followers.length}');
    });
  }

  Future<void> getFollowing() async {
    final uri =
        'https://instagram-social-api.p.rapidapi.com/v1/following?username_or_id_or_url=${widget.info['username']}'; // Replace with your API URL
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com',
        'x-rapidapi-key': '2b404bec39mshbde2af8e3242a58p1f24e7jsn5281317c8493',
      },
    );
    final json = jsonDecode(response.body) as Map;
    final resultFollowing =
        json['data']['items']
            as List; // Adjust this based on your API response structure
    setState(() {
      folowing = resultFollowing;
      print('Number of following: ${folowing.length}');
    });
  }

  Widget build(BuildContext context) {
    final info = widget.info;

    final category = info['category'] ?? '';
    final name = info['full_name'] ?? 'Default Name';
    final countFollowedBy = info['follower_count'] ?? '0';
    final following = info['following_count'] ?? '0';
    final url = info['external_url'] ?? '';
    final userImgZoom =
        info['profile_pic_url_hd'] ??
        'https://www.google.com/imgres?q=default%20image&imgurl=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F009%2F292%2F244%2Fnon_2x%2Fdefault-avatar-icon-of-social-media-user-vector.jpg&imgrefurl=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fdefault-avatar&docid=Qs-WDcyMzzrWdM&tbnid=bhXONIl2bblF7M&vet=12ahUKEwiS0sDfn4ONAxVBRKQEHYH6OTQQM3oECGQQAA..i&w=980&h=980&hcb=2&ved=2ahUKEwiS0sDfn4ONAxVBRKQEHYH6OTQQM3oECGQQAA';
    final countPosts = info['media_count'] ?? '0';
    final bio = info['biography'] ?? '';
    final userImg =
        info['profile_pic_url'] ??
        'https://scontent-lhr6-1.cdninstagram.com/v/t51.2885-19/352175288_220146187632358_8905319113431458206_n.jpg?stp=dst-jpg_e0_s150x150_tt6&_nc_ht=scontent-lhr6-1.cdninstagram.com&_nc_cat=110&_nc_oc=Q6cZ2QF9aUG0PVDUSad2uply_ZcS7NNyRag3giJqd4OUwssKfJm6Rpm2F4zVGxzboRVXFIs&_nc_ohc=obeD5OXHV_gQ7kNvwH7LJai&_nc_gid=wlQA0A7TdpBEfWdRrW2iLA&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfFSZBatoM-Mrm7rR6ZoFapOmrgQ2Ik2ekKINnEyJXlR5A&oe=6814A779&_nc_sid=8b3546';
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: name),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // Handle settings action
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            UserInfo(
              followingOntap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            FollowingsPage(following: folowing, userName: name),
                  ),
                );
              },
              onTapFollowers: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            FollowersPage(followers: followers, userName: name),
                  ),
                );
              },
              postCount: countPosts.toString(),
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false, // يجعل الخلفية شفافة
                    barrierColor: Colors.black.withOpacity(
                      0.7,
                    ), // لون غطاء خلف الصفحة
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return ProfileImageViewer(imageUrl: userImgZoom);
                    },
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
              followingNumbers: following.toString(),
              userImg: userImg,
              folowersNumber: countFollowedBy.toString(),
            ),
            const SizedBox(height: 10),
            Text(bio, textDirection: TextDirection.rtl),
            CategoryInfo(
              url: url,
              category: category,
              img: [
                followers.isNotEmpty ? followers[0]['profile_pic_url'] : '',
                followers.length > 1 ? followers[1]['profile_pic_url'] : '',
                followers.length > 2 ? followers[2]['profile_pic_url'] : '',
              ],
            ),
            const SizedBox(height: 10),
            TabBar(
              padding: const EdgeInsets.all(3),
              labelPadding: const EdgeInsets.all(10),
              dragStartBehavior: DragStartBehavior.down,
              indicatorColor: Colors.white,
              indicatorWeight: 1,

              dividerColor: Colors.white,

              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.video_library_outlined)),
                Tab(icon: Icon(Icons.assignment_ind_outlined)),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 1.1 / 2,
                    ),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return post != null
                          ? Image.network(
                            post['thumbnail_url'] ??
                                'https://www.google.com/imgres?q=default%20image&imgurl=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F009%2F292%2F244%2Fnon_2x%2Fdefault-avatar-icon-of-social-media-user-vector.jpg&imgrefurl=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fdefault-avatar&docid=Qs-WDcyMzzrWdM&tbnid=bhXONIl2bblF7M&vet=12ahUKEwiS0sDfn4ONAxVBRKQEHYH6OTQQM3oECGQQAA..i&w=980&h=980&hcb=2&ved=2ahUKEwiS0sDfn4ONAxVBRKQEHYH6OTQQM3oECGQQAA',
                            fit: BoxFit.cover,
                          )
                          : Container(color: Colors.grey);
                    },
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 0.9 / 1.6,
                    ),
                    itemCount: reals.length,
                    itemBuilder: (context, index) {
                      final reel = reals[index] ?? '';
                      return reel != null
                          ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          Video(videoUrl: reel['video_url']),
                                ),
                              );
                            },
                            child: Image.network(
                              reel['thumbnail_url'] ??
                                  'https://www.google.com/imgres?q=default%20image&imgurl=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F009%2F292%2F244%2Fnon_2x%2Fdefault-avatar-icon-of-social-media-user-vector.jpg&imgrefurl=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fdefault-avatar&docid=Qs-WDcyMzzrWdM&tbnid=bhXONIl2bblF7M&vet=12ahUKEwiS0sDfn4ONAxVBRKQEHYH6OTQQM3oECGQQAA..i&w=980&h=980&hcb=2&ved=2ahUKEwiS0sDfn4ONAxVBRKQEHYH6OTQQM3oECGQQAA',
                              fit: BoxFit.cover,
                            ),
                          )
                          : Container(color: Colors.grey);
                    },
                  ),

                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 0.8 / 1.4,
                    ),
                    itemCount: tagged.length,
                    itemBuilder: (context, index) {
                      final tag = tagged[index] ?? '';
                      return tag != null
                          ? Image.network(
                            tag['thumbnail_url'] ??
                                'https://www.google.com/imgres?q=default%20image&imgurl=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F009%2F292%2F244%2Fnon_2x%2Fdefault-avatar-icon-of-social-media-user-vector.jpg&imgrefurl=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fdefault-avatar&docid=Qs-WDcyMzzrWdM&tbnid=bhXONIl2bblF7M&vet=12ahUKEwiS0sDfn4ONAxVBRKQEHYH6OTQQM3oECGQQAA..i&w=980&h=980&hcb=2&ved=2ahUKEwiS0sDfn4ONAxVBRKQEHYH6OTQQM3oECGQQAA',
                            fit: BoxFit.cover,
                          )
                          : Container(color: Colors.grey);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
