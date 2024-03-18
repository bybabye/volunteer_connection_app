import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/features/post/data/datasource/post_data_source.dart';
import 'package:volunteer_connection/features/post/domain/entities/post.dart';

import 'package:volunteer_connection/features/post/domain/respository/post_respository.dart';

class PostRepositoryImpl implements PostRespository {
  final PostsDataSourceImlp _postDSI;
  PostRepositoryImpl(this._postDSI);

  @override
  Future<DataState<List<Post>>> getAllPost() async {
    try {
      final httpResponse = await _postDSI.getAllPost();
      if (httpResponse.statusCode == 200) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(Exception(httpResponse.statusMessage));
      }
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<Post>> createPost(Post p) async {
    try {
      final httpResponse = await _postDSI.createPost(p);
      if (httpResponse.statusCode == 200) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(Exception(httpResponse.statusMessage));
      }
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }
}
