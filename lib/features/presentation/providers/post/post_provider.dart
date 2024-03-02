import 'package:flutter/material.dart';
import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/features/data/models/post/post.dart';
import 'package:volunteer_connection/features/data/repositories/post/post_repository_impl.dart';

import 'package:volunteer_connection/features/domain/usecases/posts/get_post.dart';

enum PostStatus {
  initial,
  loading,
  success,
  failed,
}

class PostProvider extends ChangeNotifier {
  final GetPostUseCase _getPostUseCase;

  final List<PostModel> _posts;
  PostStatus _status;

  PostStatus get status => _status;

  List<PostModel> get post => _posts;

  PostProvider({getPostUseCase, posts, status})
      : _getPostUseCase = GetPostUseCase(PostRepositoryImpl()),
        _status = PostStatus.initial,
        _posts = posts ?? [];

  Future<void> getPosts() async {
    _status = PostStatus.loading;
    notifyListeners();
    try {
      final dataState = await _getPostUseCase();
      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        _posts.addAll(dataState.data!);
      }
      if (dataState is DataFailed) {
        _status = PostStatus.failed;
        print(dataState.error);
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
