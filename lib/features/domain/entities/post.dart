class Post {
  final String id;
  final List<String> images;
  final String content;
  final bool isDeleted;

  Post({
    required this.content,
    required this.id,
    required this.images,
    required this.isDeleted,
  });
}
