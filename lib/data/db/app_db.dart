// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:todo/data/db/task_dao.dart';
import 'package:todo/data/db/task_entity.dart';

part 'app_db.g.dart'; // the generated code will be there

@Database(version: 3, entities: [Task])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}