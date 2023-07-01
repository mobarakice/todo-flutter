import 'dart:core';

import 'package:todo/data/db/task_entity.dart';

abstract class Repository {
  Future<List<Task>> getTasks();

  Future saveTasks(List<Task> tasks);

  Future saveTask(Task task);

  Future updateTask(Task task);
}
