import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/features/data/datasource/post/post_data_source.dart';
import 'package:volunteer_connection/features/data/models/post/post.dart';

import 'package:volunteer_connection/features/domain/respository/post_respository.dart';

class PostRepositoryImpl implements PostRespository {
  late PostsDataSourceImlp _postDSI;
  PostRepositoryImpl() {
    _postDSI = PostsDataSourceImlp();
  }

  @override
  Future<DataState<List<PostModel>>> getAllPost() async {
    try {
      final httpResponse =
          await _postDSI.getAllPost("http://10.0.2.2:4000/v1/posts");
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