class Post {
  late String title;
  late String detail;
  late String imageUrl;
  late String id;
  late String userId;

  Post({
    required this.title,
    required this.detail,
    required this.imageUrl,
    required this.id,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      detail: json['detail'],
      imageUrl: json['imageUrl'],
      id: json['id'],
      userId: json['userId'],
    );
  }
}
