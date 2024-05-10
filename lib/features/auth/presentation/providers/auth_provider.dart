import 'package:flutter/material.dart';
import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/features/auth/data/datasource/auth_data_source.dart';
import 'package:volunteer_connection/features/auth/data/repository/auth_respository_impl.dart';
import 'package:volunteer_connection/features/auth/domain/usecase/register.dart';

class AuthProvider extends ChangeNotifier {
  final RegisterUseCase _registerUseCase;

  AuthProvider()
      : _registerUseCase =
            RegisterUseCase(AuthRepositoryImpl(AuthDataSourceImpl()));

  Future<void> register(String email, String password, String phoneNumber,
      String fullName) async {
    try {
      Map<String, dynamic> p = {
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'fullName': fullName
      };
      final dataState = await _registerUseCase(p: p);
      if (dataState is DataSuccess) {
        print("data is Success : ${dataState.data}");
      }
      if (dataState is DataFailed) {
        print("data is Failed : ${dataState.data} ${dataState.error}");
      }
    } catch (e) {
      print("data is Exception : ${e.toString()}");
    }
  }
}
