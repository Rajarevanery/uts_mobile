import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class PostDetails extends StatefulWidget {
  final int postId;
  final String imageUrl;

  const PostDetails({super.key, required this.postId, required this.imageUrl});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  Map<String, dynamic>? post;
  List<dynamic> comments = [];
  bool isLoading = true;
  bool isCommentsLoading = false;
  bool showComments = false;

  @override
  void initState() {
    super.initState();
    fetchPostById();
  }

  Future<void> fetchPostById() async {
    final url = Uri.parse(
      'http://jsonplaceholder.typicode.com/posts/${widget.postId}',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        post = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<void> fetchComments() async {
    setState(() {
      isCommentsLoading = true;
    });

    final url = Uri.parse(
      'http://jsonplaceholder.typicode.com/posts/${widget.postId}/comments',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        comments = json.decode(response.body);
        isCommentsLoading = false;
        showComments = true;
      });
    } else {
      throw Exception('Failed to load comments bruhhh');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1C),
        elevation: 0,
        title: const Text(
          'Post Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Image.network(
                          widget.imageUrl,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0xFF121212), Colors.transparent],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    post!['title'].toString().replaceAll('\n', ' '),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    post!['body'].toString().replaceAll('\n', ' '),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton.icon(
                    onPressed: fetchComments,
                    icon: const Icon(Icons.comment, color: Colors.white),
                    label: const Text(
                      "View Comments",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF2D3A45),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  if (isCommentsLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  if (showComments)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...comments.take(3).map((comment) {
                          return Container(
                            margin: const EdgeInsets.only(top: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1C),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  comment['email'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  comment['body'].toString().replaceAll(
                                    '\n',
                                    ' ',
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontFamily: 'Inter',
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            context.push('/post/${widget.postId}/comments');
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              "View All Comments",
                              style: TextStyle(
                                color: Colors.white70,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
    );
  }
}
