import 'dart:core';

import 'package:todo/data/db/task_entity.dart';

abstract class Repository {
  Future<List<TaskEntity>> getTasks();

  Future saveTasks(List<TaskEntity> tasks);
}
