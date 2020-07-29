import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_list_framework/src/blocs/albums_bloc.dart';
import 'package:my_list_framework/src/blocs/posts_bloc.dart';
import 'package:my_list_framework/src/blocs/todos_bloc.dart';
import 'package:my_list_framework/src/core/entity/JsonListEntity.dart';
import 'package:my_list_framework/src/core/entity/albums_entity.dart';
import 'package:my_list_framework/src/core/entity/posts_entity.dart';
import 'package:my_list_framework/src/core/entity/todos_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class FileController {
  static Future<File> getFile({@required nomeFile}) async {
    try {
      final diretorio = await getApplicationDocumentsDirectory();
      return File('${diretorio.path}/$nomeFile.json');
    } catch (e) {
      print('Erro ao buscar arquivo JSON \n\n $e');
      return null;
    }
  }

  static deleteDirectory() async {
    try {
      final diretorio = await getApplicationDocumentsDirectory();
      diretorio.deleteSync(recursive: true);
    } catch (e) {
      print('Erro ao excluir JSON \n\n $e');
      return null;
    }
  }

  static saveData({@required values, @required nomeFile}) async {
    try {
      final file = await getFile(nomeFile: nomeFile);
      return file.writeAsString(json.encode(values));
    } catch (e) {
      print('Erro ao salvar JSON \n\n $e');
      return null;
    }
  }

  static Future<String> readData({@required nomeFile}) async {
    try {
      final file = await getFile(nomeFile: nomeFile);
      return file.readAsString();
    } catch (e) {
      print('Erro ao ler o JSON \n\n $e');
      return null;
    }
  }

  static Future<void> jsonList() async {
    String nameFile = 'jsonList';

    final AlbumsBloc blocAlbums =
        BlocProvider.tag('blocFrwk').getBloc<AlbumsBloc>();

    final PostsBloc blocPosts =
        BlocProvider.tag('blocFrwk').getBloc<PostsBloc>();

    final TodosBloc blocTodos =
        BlocProvider.tag('blocFrwk').getBloc<TodosBloc>();

    File file = await getFile(nomeFile: nameFile);
    bool existFile = await file.exists();

    if (!existFile) {
      List<AlbumsEntity> _listAlbums = await blocAlbums.getAlbumsService();
      List<PostsEntity> _listPosts = await blocPosts.getPostService();
      List<TodosEntity> _listTodos = await blocTodos.getTodoService();

      if (_listAlbums != null &&
          _listPosts != null &&
          _listTodos != null &&
          _listAlbums.isNotEmpty &&
          _listPosts.isNotEmpty &&
          _listTodos.isNotEmpty) {

        JsonListEntity _jsonListEntity = JsonListEntity(
          albums: _listAlbums,
          posts: _listPosts,
          todos: _listTodos
        );

        saveData(
            values: _jsonListEntity,
            nomeFile: nameFile);
      }
    } else {
      String json =
      await readData(
          nomeFile: nameFile);

      final _jsonListEntity =
      jsonListEntityFromJson(json);

      blocAlbums.inAlbums.add(_jsonListEntity.albums);
      blocPosts.inPosts.add(_jsonListEntity.posts);
      blocTodos.inTodos.add(_jsonListEntity.todos);
    }
  }
}
