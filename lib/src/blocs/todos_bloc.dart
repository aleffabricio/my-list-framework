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

  Future<void> getTodoService() async {
    try {
      inTodos.add(await _todoService.getTodos());
    } catch (e) {
      _todosBloc.addError(true);
    }
  }
}
