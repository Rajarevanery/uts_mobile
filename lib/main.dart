import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:idkanymorezone/pages/post_comments_page.dart';
import 'package:idkanymorezone/pages/post_details.dart';
import 'package:idkanymorezone/pages/post_page.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => PostPage()),
    GoRoute(
      path: '/post/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        final imageUrl = state.extra as String;
        return PostDetails(postId: int.parse(id!), imageUrl: imageUrl);
      },
    ),
    GoRoute(
      path: '/post/:id/comments',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PostCommentsPage(postId: id);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
