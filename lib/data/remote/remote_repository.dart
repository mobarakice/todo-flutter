import 'dart:async';

import 'package:todo/data/repository.dart';

import '../db/task_entity.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Todos to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class RemoteRepositoryImpl implements Repository {
  final Duration delay;

  const RemoteRepositoryImpl([this.delay = const Duration(milliseconds: 3000)]);

  /// Mock that "fetches" some tasks from a "web service" after a short delay
  @override
  Future<List<TaskEntity>> getTasks() async {
    return Future.delayed(
        delay,
        () => [
              TaskEntity(
                'Buy food for da kitty',
                '1',
                'With the chickeny bits!',
                false,
              ),
              TaskEntity(
                'Find a Red Sea dive trip',
                '2',
                'Echo vs MY Dream',
                false,
              ),
              TaskEntity(
                'Book flights to Egypt',
                '3',
                '',
                true,
              ),
              TaskEntity(
                'Decide on accommodation',
                '4',
                '',
                false,
              ),
              TaskEntity(
                'Sip Margaritas',
                '5',
                'on the beach',
                true,
              ),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  @override
  Future<bool> saveTasks(List<TaskEntity> todos) async {
    return Future.value(true);
  }
}
