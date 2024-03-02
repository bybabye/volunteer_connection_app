import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/features/domain/entities/post.dart';

abstract class PostRespository {
  Future<DataState<List<Post>>> getAllPost();
}
