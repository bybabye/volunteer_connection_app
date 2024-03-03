import 'package:flutter/material.dart';
import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/features/post/data/datasource/post_data_source.dart';
import 'package:volunteer_connection/features/post/data/repositories/post_repository_impl.dart';

import 'package:volunteer_connection/features/post/domain/entities/post.dart';

import 'package:volunteer_connection/features/post/domain/usecases/get_post.dart';

enum PostStatus {
  initial,
  loading,
  success,
  failed,
}

class PostProvider extends ChangeNotifier {
  final GetPostUseCase _getPostUseCase;

  final List<Post> _posts;
  PostStatus _status;
  String error = "";
  PostStatus get status => _status;

  List<Post> get post => _posts;

  PostProvider({posts})
      : _getPostUseCase =
            GetPostUseCase(PostRepositoryImpl(PostsDataSourceImlp())),
        _status = PostStatus.initial,
        _posts = posts ?? [];

  Future<void> getPosts() async {
    _status = PostStatus.loading;
    notifyListeners();
    try {
      final dataState = await _getPostUseCase();
      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        _posts.addAll(dataState.data!);
        print(dataState.data!);
      }
      if (dataState is DataFailed) {
        _status = PostStatus.failed;
        print(dataState.error);
        error = dataState.error.toString();
        notifyListeners();
        return;
      }
    } catch (e) {
      _status = PostStatus.failed;
      notifyListeners();
      print(e);
    }

    _status = PostStatus.success;
    notifyListeners();
  }
}
