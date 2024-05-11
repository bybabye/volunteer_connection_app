import 'package:dio/dio.dart';
import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/features/auth/data/datasource/auth_data_source.dart';
import 'package:volunteer_connection/features/auth/domain/entities/user.dart';
import 'package:volunteer_connection/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSourceImpl _authDSI;

  AuthRepositoryImpl(this._authDSI);
  @override
  Future<DataState<User>> register(
      {required String email,
      required String password,
      required String phoneNumber,
      required String fullName}) async {
    try {
      final httpResponse = await _authDSI.register(
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          fullName: fullName);

      if (httpResponse.statusCode == 200) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
          DioException(
            message: httpResponse.statusMessage,
            requestOptions: RequestOptions(),
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> login(
      {required String email, required String password}) async {
    try {
      final httpResponse = await _authDSI.login(
        email: email,
        password: password,
      );

      if (httpResponse.statusCode == 200) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
          DioException(
            message: httpResponse.statusMessage,
            requestOptions: RequestOptions(),
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<User>> getUser({required String id}) async {
    try {
      final httpResponse = await _authDSI.getUser(id: id);

      if (httpResponse.statusCode == 200) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
          DioException(
            message: httpResponse.statusMessage,
            requestOptions: RequestOptions(),
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
