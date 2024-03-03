import 'package:dio/dio.dart';

import 'package:volunteer_connection/features/post/domain/entities/post.dart';

abstract class PostsDataSource {
  Future<Response<List<Post>>> getAllPost(String api);
}

class PostsDataSourceImlp implements PostsDataSource {
  late Dio dio;

  PostsDataSourceImlp() {
    dio = Dio();
  }

  @override
  Future<Response<List<Post>>> getAllPost(String api) async {
    Response response;

    try {
      response = await dio.get(api);
      List<Post> result =
          (response.data!['data'] as List).map<Post>((dynamic i) {
        return Post.fromJson(
          i as Map<String, dynamic>,
        );
      }).toList();
      return Response(
        statusCode: 200,
        data: result,
        requestOptions: RequestOptions(),
      );
    } catch (e) {
      return Response(
        statusCode: 500,
        statusMessage: e.toString(),
        data: [],
        requestOptions: RequestOptions(),
      );
    }
  }
}
