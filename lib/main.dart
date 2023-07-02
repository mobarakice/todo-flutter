import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/db/db_repository_impl.dart';
import 'package:todo/data/local/key_value_storage.dart';
import 'package:todo/data/local/local_repository_impl.dart';
import 'package:todo/models/todo_list_model.dart';
import 'package:todo/utils/routes.dart';
import 'package:todo/utils/theme.dart';

import 'data/db/app_db.dart';
import 'data/repository.dart';
import 'localizations/localization.dart';
import 'ui/add_edit/add_screen.dart';
import 'ui/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(TodoApp(
      repository: LocalStorageRepository(
          dbRepo: DbRepositoryImpl(await $FloorAppDatabase
              .databaseBuilder('app_database.db')
              .build()),
          localRepo: KeyValueStorage(
              "ttt",
              KeyValueStore(await SharedPreferences.getInstance()),
              const JsonCodec()))));
}

class TodoApp extends StatelessWidget {
  final Repository repository;

  const TodoApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoListModel(repository: repository)..loadTodos(),
      child: MaterialApp(
        theme: TodoTheme.theme,
        builder: (context, child) {
          return CupertinoTheme(
            // Instead of letting Cupertino widgets auto-adapt to the Material
            // theme (which is green), this app will use a different theme
            // for Cupertino (which is blue by default).
            data: const CupertinoThemeData(),
            child: Material(child: child),
          );
        },
        localizationsDelegates: [
          TodoLocalizationsDelegate(),
          ProviderLocalizationsDelegate(),
        ],
        onGenerateTitle: (context) =>
            ProviderLocalizations.of(context)?.appTitle as String,
        routes: {
          TodoRoutes.home: (context) => const HomeScreen(),
          TodoRoutes.addTodo: (context) => const AddTaskScreen(),
        },
      ),
    );
  }
}
