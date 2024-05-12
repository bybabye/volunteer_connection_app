import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/core/usecase/usecase.dart';
import 'package:volunteer_connection/features/auth/data/repository/auth_respository_impl.dart';
import 'package:volunteer_connection/core/entites/user.dart';

class GetUserUseCase implements UseCase<DataState<User>, String> {
  final AuthRepositoryImpl _authRI;

  GetUserUseCase(this._authRI);
  @override
  Future<DataState<User>> call({String? p}) {
    return _authRI.getUser(id: p!);
  }
}
