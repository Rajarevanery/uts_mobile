import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idkanymorezone/models/comment.dart';
import '../models/post.dart';

class PostController {
  static Future<List<Post>> fetchPosts() async {
    final url = Uri.parse('http://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch posts :(');
    }
  }

  static Future<Post> fetchPostById(int id) async {
    final url = Uri.parse('http://jsonplaceholder.typicode.com/posts/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Post failed');
    }
  }

  static Future<List<Comment>> fetchCommentsByPostId(int postId) async {
    final url = Uri.parse(
      'http://jsonplaceholder.typicode.com/posts/$postId/comments',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Load Comment failed');
    }
  }
}
