class User {
  String nickname;

  User({required this.nickname});

  User copyWith({required String nickname}) {
    return User(
      nickname: nickname,
    );
  }
}
