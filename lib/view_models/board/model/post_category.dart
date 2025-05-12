enum PostCategoryType {
  ALL,
  FREE,
  CERT,
  NOTICE
}

class PostCategory {
  final int id;
  final String name;
  final PostCategoryType type;
  final String activeIcon;
  final String inactiveIcon;

  PostCategory({required this.id, required this.name, required this.type, required this.activeIcon, required this.inactiveIcon});
}