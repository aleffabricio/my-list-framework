import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:my_list_framework/src/core/entity/posts_entity.dart';
import 'package:my_list_framework/src/core/service/posts_service.dart';
import 'package:rxdart/rxdart.dart';

class PostsBloc implements BlocBase {
  PostService _postService = PostService();

  var _postsBloc = BehaviorSubject<List<PostsEntity>>();

  Stream<List<PostsEntity>> get outPosts => _postsBloc.stream;

  Sink<List<PostsEntity>> get inPosts => _postsBloc.sink;

  @override
  void addListener(listener) {}

  @override
  void dispose() {
    _postsBloc.close();
  }

  @override
  bool get hasListeners => null;

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}

  Future<List<PostsEntity>> getPostService() async {
    try {
      List<PostsEntity> listPosts = List<PostsEntity>();
      listPosts = await _postService.getPosts();
      inPosts.add(listPosts);
      return listPosts;
    } catch (e) {
      _postsBloc.addError(true);
      return null;
    }
  }
}
