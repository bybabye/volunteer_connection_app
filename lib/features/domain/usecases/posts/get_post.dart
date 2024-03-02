import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/core/usecase/usecase.dart';
import 'package:volunteer_connection/features/data/models/post/post.dart';
import 'package:volunteer_connection/features/data/repositories/post/post_repository_impl.dart';

class GetPostUseCase implements UseCase<DataState<List<PostModel>>, void> {
  final PostRepositoryImpl _postRI;
  GetPostUseCase(this._postRI);
  @override
  Future<DataState<List<PostModel>>> call({void p}) {
    return _postRI.getAllPost();
  }
}
