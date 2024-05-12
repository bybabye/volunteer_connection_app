import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/core/usecase/usecase.dart';
import 'package:volunteer_connection/features/auth/data/repository/auth_respository_impl.dart';

import '../../../../core/entites/user.dart';

class RegisterUseCase
    implements UseCase<DataState<User>, Map<String, dynamic>> {
  final AuthRepositoryImpl _authRI;

  RegisterUseCase(this._authRI);

  @override
  Future<DataState<User>> call({Map<String, dynamic>? p}) {
    return _authRI.register(
      email: p!['email'],
      password: p['password'],
      phoneNumber: p['phoneNumber'],
      fullName: p['fullName'],
    );
  }
}
