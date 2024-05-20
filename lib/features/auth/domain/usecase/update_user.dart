import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/core/usecase/usecase.dart';
import 'package:volunteer_connection/features/auth/data/repository/auth_respository_impl.dart';
import 'package:volunteer_connection/core/entites/user.dart';

class UpdateUserUseCase extends UseCase<DataState<User>, Map<String, String>> {
  final AuthRepositoryImpl _authRI;

  UpdateUserUseCase(this._authRI);
  @override
  Future<DataState<User>> call({required Map<String, String> p}) {
    return _authRI.updateUser(
      id: p['id']!,
      userName: p['userName']!,
      email: p['email']!,
      phone: p['phone']!,
      placeOfOrigin: p['placeOfOrigin']!,
    );
  }
}
