import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:my_list_framework/src/core/entity/albums_entity.dart';
import 'package:my_list_framework/src/core/service/albums_service.dart';
import 'package:rxdart/rxdart.dart';

class AlbumsBloc implements BlocBase {
  AlbumsService _albumsService = AlbumsService();

  var _albumsBloc = BehaviorSubject<List<AlbumsEntity>>();

  Stream<List<AlbumsEntity>> get outAlbums => _albumsBloc.stream;

  Sink<List<AlbumsEntity>> get inAlbums => _albumsBloc.sink;

  @override
  void addListener(listener) {}

  @override
  void dispose() {
    _albumsBloc.close();
  }

  @override
  bool get hasListeners => null;

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}

  Future<List<AlbumsEntity>> getAlbumsService() async {
    try {
      List<AlbumsEntity> _listAlbums = List<AlbumsEntity>();
      _listAlbums = await _albumsService.getAlbums();
      inAlbums.add(_listAlbums);
      return _listAlbums;
    } catch (e) {
      _albumsBloc.addError(true);
      return null;
    }
  }

  addErrorConnection() {
    _albumsBloc.addError('Você está sem rede, ative para o app buscar os dados.');
  }

  addErrorFile() {
    _albumsBloc.addError('Ocorreu algum problema na API Rest');
  }

}
