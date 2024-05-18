import 'package:flutter/material.dart';
import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/features/auth/data/datasource/auth_data_source.dart';
import 'package:volunteer_connection/features/auth/data/repository/auth_respository_impl.dart';
import 'package:volunteer_connection/core/entites/user.dart';
import 'package:volunteer_connection/features/auth/domain/usecase/get_user.dart';
import 'package:volunteer_connection/features/auth/domain/usecase/login.dart';
import 'package:volunteer_connection/features/auth/domain/usecase/register.dart';
import 'package:volunteer_connection/features/auth/domain/usecase/update_user.dart';

class AuthProvider extends ChangeNotifier {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final GetUserUseCase _getUserUseCase;
  final UpdateUserUseCase _updateUserUseCase;
  late User user;

  AuthProvider()
      : _registerUseCase =
            RegisterUseCase(AuthRepositoryImpl(AuthDataSourceImpl())),
        _getUserUseCase =
            GetUserUseCase(AuthRepositoryImpl(AuthDataSourceImpl())),
        _loginUseCase = LoginUseCase(AuthRepositoryImpl(AuthDataSourceImpl())),
        _updateUserUseCase =
            UpdateUserUseCase(AuthRepositoryImpl(AuthDataSourceImpl()));

  Future<String> register(String email, String password, String phoneNumber,
      String fullName) async {
    try {
      Map<String, dynamic> p = {
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'fullName': fullName
      };
      final dataState = await _registerUseCase(p: p);

      if (dataState is DataFailed) {
        print("data is Failed :  ${dataState.error!.message}");
        return "${dataState.error!.message}";
      }
      if (dataState is DataSuccess) {
        print("data is Success : ${dataState.data}");
      }
      return "success";
    } catch (e) {
      print("data is Exception : ${e.toString()}");
      return e.toString();
    }
  }

  Future<Map<String, String>> login(String email, String password) async {
    try {
      Map<String, dynamic> p = {'email': email, 'password': password};
      final dataState = await _loginUseCase(p: p);
      if (dataState is DataSuccess) {
        print(" DataSuccess hàm login ở authentication ${dataState.data}");
        return {"success": dataState.data!};
      }
      if (dataState is DataFailed) {
        print(
            " DataFailed hàm login ở authentication ${dataState.error!.message!}");
        return {"error": dataState.error!.message!};
      }
      return {'': ''};
    } catch (e) {
      print(" catch hàm login ở authentication $e");
      return {"error": e.toString()};
    }
  }

  Future<void> getUser(String id) async {
    try {
      final dataState = await _getUserUseCase(p: id);
      if (dataState is DataSuccess) {
        user = dataState.data!;
        print(" DataSuccess hàm getUser ở authentication ${dataState.data}");
      }
      if (dataState is DataFailed) {
        print(
            " DataFailed hàm getUser ở authentication ${dataState.error!.message!}");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> updateUser(String id, String userName, String email,
      String phone, String placeOfOrigin) async {
    try {
      // Construct parameters map
      Map<String, String> p = {
        'id': id,
        'userName': userName,
        'email': email,
        'phone': phone,
        'placeOfOrigin': placeOfOrigin
      };
      print("Update parameters: $p");

      // Call the update user use case
      final dataState = await _updateUserUseCase(p: p);
      if (dataState is DataFailed) {
        print("Data update failed: ${dataState.error?.message}");
        return dataState.error?.message ?? "Unknown error";
      }
      if (dataState is DataSuccess) {
        // Assuming dataState.data contains the updated user information
        print("Data update succeeded: ${dataState.data}");

        // Update the AuthProvider's user object using copyWith
        user = user.copyWith(
          name: userName,
          email: email,
          phone: phone,
          placeOfOrigin: placeOfOrigin,
        );

        // Notify listeners of the change
        notifyListeners();
        return "success";
      }
      return "Unknown state";
    } catch (e) {
      print("Exception during data update: ${e.toString()}");
      return e.toString();
    }
  }
}
