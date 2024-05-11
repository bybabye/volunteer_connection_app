import 'package:dio/dio.dart';
import 'package:volunteer_connection/features/auth/domain/entities/user.dart';

abstract class AuthDataSource {
  Future<Response<User>> register({
    required String email,
    required String password,
    required String phoneNumber,
    required String fullName,
  });
}

class AuthDataSourceImpl implements AuthDataSource {
  final dio = Dio();
  @override
  Future<Response<User>> register({
    required String email,
    required String password,
    required String phoneNumber,
    required String fullName,
  }) async {
    Response response;

    try {
      response = await dio.post("http://10.0.2.2:3001/api/user/sign-up", data: {
        'email': email,
        'password': password,
        'phone': phoneNumber,
        'name': fullName,
      });

      User result =
          User.fromJson(response.data!['data'] as Map<String, dynamic>);
      return Response(
        statusCode: 200,
        data: result,
        requestOptions: RequestOptions(),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        return Response(
          statusCode: e.response!.statusCode,
          statusMessage: e.response!.data['message'],
          data: null,
          requestOptions: RequestOptions(),
        );
      } else {
        return Response(
          statusCode: 500,
          statusMessage: e.toString(),
          data: null,
          requestOptions: RequestOptions(),
        );
      }
    }
  }
}
