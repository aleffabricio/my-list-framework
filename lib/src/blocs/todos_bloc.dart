import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:my_list_framework/src/core/entity/todos_entity.dart';
import 'package:my_list_framework/src/core/service/todos_service.dart';
import 'package:rxdart/rxdart.dart';

class TodosBloc implements BlocBase {
  TodoService _todoService = TodoService();

  var _todosBloc = BehaviorSubject<List<TodosEntity>>();

  Stream<List<TodosEntity>> get outTodos => _todosBloc.stream;

  Sink<List<TodosEntity>> get inTodos => _todosBloc.sink;

  @override
  void addListener(listener) {}

  @override
  void dispose() {
    _todosBloc.close();
  }

  @override
  bool get hasListeners => null;

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}

  Future<List<TodosEntity>> getTodoService() async {
    try {
      List<TodosEntity> _listTodos = List<TodosEntity>();
      _listTodos = await _todoService.getTodos();
      inTodos.add(_listTodos);
      return _listTodos;
    } catch (e) {
      _todosBloc.addError(true);
      return null;
    }
  }

  addErrorConnection() {
    _todosBloc.addError('Você está sem rede, ative para o app buscar os dados.');
  }

  addErrorFile() {
    _todosBloc.addError('Ocorreu algum problema na API Rest');
  }
}
