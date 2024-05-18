import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:volunteer_connection/config/constanst_config.dart';
import 'package:volunteer_connection/core/entites/user.dart';

abstract class AuthDataSource {
  Future<Response<User>> register({
    required String email,
    required String password,
    required String phoneNumber,
    required String fullName,
  });
  Future<Response<String>> login(
      {required String email, required String password});
  Future<Response<User>> getUser({required String id});
  Future<Response<User>> updateUser(
      {required String id,
      required String userName,
      required String email,
      required String phone,
      required String placeOfOrigin});
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
      response = await dio.post(ConstanstConfig.signIn1, data: {
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
          statusMessage: e.response!.data['message']['message'],
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

  @override
  Future<Response<String>> login(
      {required String email, required String password}) async {
    Response response;
    try {
      response = await dio.post(ConstanstConfig.login1, data: {
        'email': email,
        'password': password,
      });

      return Response(
        statusCode: 200,
        data: response.data!['id'],
        requestOptions: RequestOptions(),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        return Response(
          statusCode: e.response!.statusCode,
          statusMessage: e.response!.data['message']['message'],
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

  @override
  Future<Response<User>> getUser({required String id}) async {
    Response response;
    try {
      response = await dio.get("${ConstanstConfig.getUser1}/$id");
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
          statusMessage: e.response!.data['message']['message'],
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

  @override
  Future<Response<User>> updateUser(
      {required String id,
      required String userName,
      required String email,
      required String phone,
      required String placeOfOrigin}) async {
    Response response;
    try {
      response = await dio.put("${ConstanstConfig.updateUser1}/$id", data: {
        'name': userName,
        'email': email,
        'phone': phone,
        'placeOfOrigin': placeOfOrigin,
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
          statusMessage: e.response!.data['message']['message'],
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
