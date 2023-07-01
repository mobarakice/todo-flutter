import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:todo/data/db/task_entity.dart';
import 'package:todo/data/repository.dart';
import 'package:todo/data/remote/remote_repository.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class LocalStorageRepository implements Repository {
  final Repository localRepo;
  final Repository remoteRepo;
  final Repository dbRepo;

  const LocalStorageRepository({
    required this.dbRepo,
    required this.localRepo,
    this.remoteRepo = const RemoteRepositoryImpl(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<Task>> getTasks() async {
    List<Task> tasks=[];
    try {
      tasks = await dbRepo.getTasks();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }finally{
      if(tasks.isEmpty) {
        tasks = await remoteRepo.getTasks();
        await dbRepo.saveTasks(tasks);
        tasks = await dbRepo.getTasks();
      }
    }
    return tasks;
  }

  // Persists todos to local disk and the web
  @override
  Future saveTasks(List<Task> tasks) {
    return Future.wait<dynamic>([
      dbRepo.saveTasks(tasks),
      remoteRepo.saveTasks(tasks),
    ]);
  }

  @override
  Future saveTask(Task task) {
    return Future.wait<dynamic>([
      dbRepo.saveTask(task),
      remoteRepo.saveTask(task),
    ]);
  }

  @override
  Future updateTask(Task task) {
    return Future.wait<dynamic>([
      dbRepo.updateTask(task),
      remoteRepo.updateTask(task),
    ]);
  }
}
