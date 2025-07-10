class Comment {
  final int id;
  final String email;
  final String body;

  Comment({required this.id, required this.email, required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      Comment(id: json['id'], email: json['email'], body: json['body']);
}
