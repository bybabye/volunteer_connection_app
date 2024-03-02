import 'package:volunteer_connection/features/domain/entities/post.dart';

class PostModel extends Post {
  PostModel(
      {required super.content,
      required super.id,
      required super.images,
      required super.isDeleted});
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      content: json['content'] ?? "",
      id: json['_id'] ?? "",
      images: json['images'].cast<String>() ?? [],
      isDeleted: json['isDeleted'] ?? "",
    );
  }
}
