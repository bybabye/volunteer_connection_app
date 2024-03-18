import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/core/usecase/usecase.dart';
import 'package:volunteer_connection/features/post/data/repository/post_repository_impl.dart';
import 'package:volunteer_connection/features/post/domain/entities/post.dart';

class CreatePostUseCase implements UseCase<DataState<Post>, Post> {
  final PostRepositoryImpl _postRI;
  CreatePostUseCase(this._postRI);
  @override
  Future<DataState<Post>> call({Post? p}) {
    if (p == null) {
      return Future.value(DataFailed(Exception('Post cannot be null')));
    }
    return _postRI.createPost(p);
  }
}
