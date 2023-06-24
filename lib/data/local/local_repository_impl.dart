import 'dart:core';

import 'package:todo/data/db/task_entity.dart';
import 'package:todo/data/repository.dart';
import 'package:todo/data/remote/remote_repository.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class LocalStorageRepository implements Repository {
  final Repository localRepo;
  final Repository remoteRepo;

  const LocalStorageRepository({
    required this.localRepo,
    this.remoteRepo = const RemoteRepositoryImpl(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<TaskEntity>> getTasks() async {
    try {
      return await localRepo.getTasks();
    } catch (e) {
      final tasks = await remoteRepo.getTasks();

      await localRepo.saveTasks(tasks);

      return tasks;
    }
  }

  // Persists todos to local disk and the web
  @override
  Future saveTasks(List<TaskEntity> tasks) {
    return Future.wait<dynamic>([
      localRepo.saveTasks(tasks),
      remoteRepo.saveTasks(tasks),
    ]);
  }
}
