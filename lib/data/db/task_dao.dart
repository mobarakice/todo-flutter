import 'package:floor/floor.dart';
import 'package:todo/data/db/task_entity.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM Task')
  Future<List<Task>> getTasks();

  @Query('SELECT * FROM Task WHERE id = :id')
  Stream<Task?> findTaskById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertTasks(List<Task> tasks);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertTask(Task task);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateTask(Task task);
}