import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/core/usecase/usecase.dart';
import 'package:volunteer_connection/features/auth/data/repository/auth_respository_impl.dart';

class LoginUseCase
    implements UseCase<DataState<String>, Map<String, dynamic>?> {
  final AuthRepositoryImpl _authRI;

  LoginUseCase(this._authRI);
  @override
  Future<DataState<String>> call({Map<String, dynamic>? p}) {
    return _authRI.login(
      email: p!['email'],
      password: p['password'],
    );
  }
}
