import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/core/usecase/usecase.dart';

import 'package:volunteer_connection/features/post/data/repositories/post_repository_impl.dart';
import 'package:volunteer_connection/features/post/domain/entities/post.dart';

class GetPostUseCase implements UseCase<DataState<List<Post>>, void> {
  final PostRepositoryImpl _postRI;
  GetPostUseCase(this._postRI);
  @override
  Future<DataState<List<Post>>> call({void p}) {
    return _postRI.getAllPost();
  }
}
