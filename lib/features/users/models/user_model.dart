// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  late String email;
  late String userImage;
  late String username;
  User({
    required this.email,
    required this.userImage,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      userImage: json['userImage'],
      username: json['username'],
    );
  }
}
