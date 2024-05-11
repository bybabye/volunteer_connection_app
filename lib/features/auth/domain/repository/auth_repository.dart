import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<DataState<User>> register({
    required String email,
    required String password,
    required String phoneNumber,
    required String fullName,
  });
  Future<DataState<String>> login(
      {required String email, required String password});
  Future<DataState<User>> getUser({required String id});
}
