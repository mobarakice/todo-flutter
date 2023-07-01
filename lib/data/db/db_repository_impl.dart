import 'package:todo/data/db/app_db.dart';
import 'package:todo/data/db/task_entity.dart';
import 'package:todo/data/repository.dart';

class DbRepositoryImpl implements Repository {
  final AppDatabase database;

  DbRepositoryImpl(this.database);

  @override
  Future<List<Task>> getTasks() {
    return database.taskDao.getTasks();
  }

  @override
  Future<List<int>> saveTasks(List<Task> tasks) {
    return database.taskDao.insertTasks(tasks);
  }

  @override
  Future saveTask(Task task) {
    return database.taskDao.insertTask(task);
  }

  @override
  Future updateTask(Task task) {
    return database.taskDao.updateTask(task);
  }
}
