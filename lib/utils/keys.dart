import 'package:flutter/widgets.dart';

class TodoKeys {
  // Home Screens
  static const homeScreen = Key('__homeScreen__');
  static const addTodoFab = Key('__addTodoFab__');
  static const snackBar = Key('__snackBar__');

  static Key snackBarAction(int id) => Key('__snackBar_action_${id}__');

  // Todos
  static const todoList = Key('__todoList__');
  static const todosLoading = Key('__todosLoading__');

  static Key todoItem(int id) => Key('TodoItem__$id');

  static Key todoItemCheckbox(int id) => Key('TodoItem__${id}__Checkbox');

  static Key todoItemTask(int id) => Key('TodoItem__${id}__Task');

  static Key todoItemNote(int id) => Key('TodoItem__${id}__Note');

  // Tabs
  static const tabs = Key('__tabs__');
  static const todoTab = Key('__todoTab__');
  static const statsTab = Key('__statsTab__');

  // Extra Actions
  static const extraActionsButton = Key('__extraActionsButton__');
  static const toggleAll = Key('__markAllDone__');
  static const clearCompleted = Key('__clearCompleted__');

  // Filters
  static const filterButton = Key('__filterButton__');
  static const allFilter = Key('__allFilter__');
  static const activeFilter = Key('__activeFilter__');
  static const completedFilter = Key('__completedFilter__');

  // Stats
  static const statsCounter = Key('__statsCounter__');
  static const statsLoading = Key('__statsLoading__');
  static const statsNumActive = Key('__statsActiveItems__');
  static const statsNumCompleted = Key('__statsCompletedItems__');

  // Details Screen
  static const editTodoFab = Key('__editTodoFab__');
  static const deleteTodoButton = Key('__deleteTodoFab__');
  static const todoDetailsScreen = Key('__todoDetailsScreen__');
  static const detailsTodoItemCheckbox = Key('DetailsTodo__Checkbox');
  static const detailsTodoItemTask = Key('DetailsTodo__Task');
  static const detailsTodoItemNote = Key('DetailsTodo__Note');

  // Add Screen
  static const addTodoScreen = Key('__addTodoScreen__');
  static const saveNewTodo = Key('__saveNewTodo__');
  static const taskField = Key('__taskField__');
  static const noteField = Key('__noteField__');

  // Edit Screen
  static const editTodoScreen = Key('__editTodoScreen__');
  static const saveTodoFab = Key('__saveTodoFab__');
}
