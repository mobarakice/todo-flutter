import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/db/task_entity.dart';
import 'package:todo/data/repository.dart';

/// Loads and saves a List of Todos using a provided KeyValueStore, which works
/// on mobile and web. On mobile, it uses the SharedPreferences package, on web
/// it uses window.localStorage.
///
/// Can be used as it's own repository, or mixed together with other storage
/// solutions, such as the the WebClient, which can be seen in the
/// LocalStorageRepository.
class KeyValueStorage implements Repository {
  final String key;
  final KeyValueStore store;
  final JsonCodec codec;

  const KeyValueStorage(this.key, this.store, [this.codec = json]);

  @override
  Future<List<TaskEntity>> getTasks() async {
    return codec
        .decode(store.getString(key))['tasks']
        .cast<Map<String, Object>>()
        .map<TaskEntity>(TaskEntity.fromJson)
        .toList(growable: false);
  }

  @override
  Future<bool> saveTasks(List<TaskEntity> tasks) {
    return store.setString(
      key,
      codec.encode({
        'tasks': tasks.map((todo) => todo.toJson()).toList(),
      }),
    );
  }
}

class KeyValueStore {
  late SharedPreferences prefs;

  KeyValueStore(this.prefs);

  String getString(String key) {
    return prefs.getString(key) ?? "";
  }

  Future<bool> setString(String key, String value) {
    return prefs.setString(key, value);
  }
}
