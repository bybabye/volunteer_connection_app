import 'package:dio/dio.dart';

import 'package:volunteer_connection/features/post/domain/entities/post.dart';

abstract class PostsDataSource {
  Future<Response<List<Post>>> getAllPost();
  Future<Response<Post>> createPost(Post p);
}

// chịu trách nhiệm gọi api chuyển đổi dữ liệu và bắt các exception
class PostsDataSourceImlp implements PostsDataSource {
  final dio = Dio();

  @override
  Future<Response<List<Post>>> getAllPost() async {
    Response response;

    try {
      response = await dio.get("http://10.0.2.2:4000/v1/posts");
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
        data: null,
        requestOptions: RequestOptions(),
      );
    }
  }

  @override
  Future<Response<Post>> createPost(Post p) async {
    Response response;
    try {
      response =
          await dio.post("http://10.0.2.2:4000/v1/add", data: p.toJson());
      Post result = Post.fromJson(response.data!['data']);
      return Response(
        statusCode: 200,
        data: result,
        requestOptions: RequestOptions(),
      );
    } catch (e) {
      return Response(
        statusCode: 500,
        statusMessage: e.toString(),
        data: null,
        requestOptions: RequestOptions(),
      );
    }
  }
}
