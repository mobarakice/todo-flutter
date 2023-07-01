import 'dart:async';
import 'dart:collection';

import 'package:flutter/widgets.dart';

import '../data/db/task_entity.dart';
import '../data/repository.dart';

enum VisibilityFilter { all, active, completed }

class TodoListModel extends ChangeNotifier {
  final Repository repository;

  VisibilityFilter _filter;

  VisibilityFilter get filter => _filter;

  set filter(VisibilityFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  List<Task> _todos;

  UnmodifiableListView<Task> get todos => UnmodifiableListView(_todos);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  TodoListModel({
    required this.repository,
    var filter,
    var todos,
  })  : _todos = todos ?? [],
        _filter = filter ?? VisibilityFilter.all;

  /// Loads remote data
  ///
  /// Call this initially and when the user manually refreshes
  Future loadTodos() {
    _isLoading = true;
    notifyListeners();

    return repository.getTasks().then((loadedTodos) {
      _todos.addAll(loadedTodos);
      _isLoading = false;
      notifyListeners();
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
    });
  }

  List<Task> get filteredTodos {
    return _todos.where((todo) {
      switch (filter) {
        case VisibilityFilter.active:
          return !todo.complete;
        case VisibilityFilter.completed:
          return todo.complete;
        case VisibilityFilter.all:
        default:
          return true;
      }
    }).toList();
  }

  void clearCompleted() {
    _todos.removeWhere((todo) => todo.complete);
    notifyListeners();
    _uploadItems();
  }

  void toggleAll() {
    var allComplete = todos.every((todo) => todo.complete);
    _todos = _todos
        .map<Task>((todo) => todo.copy(todo, complete: !allComplete))
        .toList();
    notifyListeners();
    _uploadItems();
  }

  /// updates a [Task] by replacing the item with the same id by the parameter [todo]
  void updateTodo(Task todo) {
    var oldTodo = _todos.firstWhere((it) => it.id == todo.id);
    var replaceIndex = _todos.indexOf(oldTodo);
    _todos.replaceRange(replaceIndex, replaceIndex + 1, [todo]);
    notifyListeners();
    _uploadItems();
  }

  void removeTodo(Task todo) {
    _todos.removeWhere((it) => it.id == todo.id);
    notifyListeners();
    _uploadItems();
  }

  void addTodo(Task todo) {
    _todos.add(todo);
    notifyListeners();
    _uploadItems();
  }

  void _uploadItems() {
    repository.saveTasks(_todos);
  }

  Task todoById(int id) {
    return _todos.firstWhere((it) => it.id == id);
  }

  int get numCompleted =>
      todos.where((Task todo) => todo.complete).toList().length;

  bool get hasCompleted => numCompleted > 0;

  int get numActive =>
      todos.where((Task todo) => !todo.complete).toList().length;

  bool get hasActiveTodos => numActive > 0;
}
