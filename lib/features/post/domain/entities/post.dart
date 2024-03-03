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

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      content: json['content'] ?? "",
      id: json['_id'] ?? "",
      images: json['images'].cast<String>() ?? [],
      isDeleted: json['isDeleted'] ?? "",
    );
  }
}
