class Post {
  late String title;
  late String detail;
  late String imageUrl;
  late String id; //post id
  late String userId; //user id
  late String imageId;
  late Like likes;

  Post({
    required this.title,
    required this.detail,
    required this.imageUrl,
    required this.id,
    required this.userId,
    required this.imageId,
    required this.likes,
  });
}

class Like {
  late List username;
  late int like;

  Like({
    required this.username,
    required this.like,
  });
  Map<String, dynamic> toJson() {
    return {
      'username': this.username,
      'like': this.like,
    };
  }

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      username: json['username'] as List<String>,
      like: json['like'],
    );
  }
}
