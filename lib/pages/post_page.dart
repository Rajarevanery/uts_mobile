// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:idkanymorezone/controller/post_controller.dart';
import 'package:idkanymorezone/models/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Post> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final posts = await PostController.fetchPosts();
      setState(() {
        _data = posts;
      });
    } catch (e) {
      print('Error loading posts bruh: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(color: Colors.transparent),
          ),
        ),
        backgroundColor: Color(0xFF1A1A1C).withAlpha(200),
        scrolledUnderElevation: 0,
        elevation: 0,

        // ! Backup :>
        // title: const Text(
        //   "Tests",
        //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        // ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Text(
                "R",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(width: 8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Raja Revan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "@rajarevan",
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white.withValues(alpha: 0.7),
            ),
            onPressed: () {
              print("Search");
            },
          ),
          IconButton(
            icon: Badge(
              label: Text('3', style: TextStyle(fontSize: 10)),
              child: Icon(
                Icons.notifications_none,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: _data.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            color: Color(0xFF1C1C1E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      'https://abh.ai/random/400/400?seed=$index',
                                      height: 400,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            final postId = _data[index].id;
                                            final imageUrl =
                                                'https://abh.ai/random/400/400?seed=$index';
                                            context.push(
                                              '/post/$postId',
                                              extra: imageUrl,
                                            );
                                          },
                                          label: Text(
                                            "View Post",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.article,
                                            color: Colors.white,
                                          ),
                                          style: TextButton.styleFrom(
                                            backgroundColor: Color(0xFF2D3A45),
                                          ),
                                        ),
                                        Text(
                                          "Uploaded $index minute lalu",
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _data[index].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          _data[index].body.replaceAll(
                                            '\n',
                                            ' ',
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white70,
                                            height: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
