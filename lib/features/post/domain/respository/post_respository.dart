import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/features/post/domain/entities/post.dart';

abstract class PostRespository {
  Future<DataState<List<Post>>> getAllPost();
  Future<DataState<Post>> createPost(Post p);
}
