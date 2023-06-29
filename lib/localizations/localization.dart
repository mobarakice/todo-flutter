// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class TodoLocalizations {
  TodoLocalizations(this.locale);

  final Locale locale;

  static Future<TodoLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return TodoLocalizations(locale);
    });
  }

  static TodoLocalizations? of(BuildContext context) {
    return Localizations.of<TodoLocalizations>(
        context, TodoLocalizations);
  }

  String get todos => Intl.message(
        'Todos',
        name: 'todos',
        args: [],
        locale: locale.toString(),
      );

  String get stats => Intl.message(
        'Stats',
        name: 'stats',
        args: [],
        locale: locale.toString(),
      );

  String get showAll => Intl.message(
        'Show All',
        name: 'showAll',
        args: [],
        locale: locale.toString(),
      );

  String get showActive => Intl.message(
        'Show Active',
        name: 'showActive',
        args: [],
        locale: locale.toString(),
      );

  String get showCompleted => Intl.message(
        'Show Completed',
        name: 'showCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get newTodoHint => Intl.message(
        'What needs to be done?',
        name: 'newTodoHint',
        args: [],
        locale: locale.toString(),
      );

  String get markAllComplete => Intl.message(
        'Mark all complete',
        name: 'markAllComplete',
        args: [],
        locale: locale.toString(),
      );

  String get markAllIncomplete => Intl.message(
        'Mark all incomplete',
        name: 'markAllIncomplete',
        args: [],
        locale: locale.toString(),
      );

  String get clearCompleted => Intl.message(
        'Clear completed',
        name: 'clearCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get addTask => Intl.message(
        'Add Task',
        name: 'addTask',
        args: [],
        locale: locale.toString(),
      );

  String get editTask => Intl.message(
        'Edit Task',
        name: 'editTask',
        args: [],
        locale: locale.toString(),
      );

  String get saveChanges => Intl.message(
        'Save changes',
        name: 'saveChanges',
        args: [],
        locale: locale.toString(),
      );

  String get filterTasks => Intl.message(
        'Filter Tasks',
        name: 'filterTasks',
        args: [],
        locale: locale.toString(),
      );

  String get deleteTask => Intl.message(
        'Delete Task',
        name: 'deleteTask',
        args: [],
        locale: locale.toString(),
      );

  String get taskDetails => Intl.message(
        'Task Details',
        name: 'taskDetails',
        args: [],
        locale: locale.toString(),
      );

  String get emptyTaskError => Intl.message(
        'Please enter some text',
        name: 'emptyTaskError',
        args: [],
        locale: locale.toString(),
      );

  String get descriptionHint => Intl.message(
        'Additional Notes...',
        name: 'descriptionHint',
        args: [],
        locale: locale.toString(),
      );

  String get completedTasks => Intl.message(
        'Completed Tasks',
        name: 'completedTasks',
        args: [],
        locale: locale.toString(),
      );

  String get activeTasks => Intl.message(
        'Active Tasks',
        name: 'activeTasks',
        args: [],
        locale: locale.toString(),
      );

  String taskDeleted(String task) => Intl.message(
        'Deleted "$task"',
        name: 'taskDeleted',
        args: [task],
        locale: locale.toString(),
      );

  String get undo => Intl.message(
        'Undo',
        name: 'undo',
        args: [],
        locale: locale.toString(),
      );

  String get deleteTaskConfirmation => Intl.message(
        'Delete this task?',
        name: 'deleteTaskConfirmation',
        args: [],
        locale: locale.toString(),
      );

  String get delete => Intl.message(
        'Delete',
        name: 'delete',
        args: [],
        locale: locale.toString(),
      );

  String get cancel => Intl.message(
        'Cancel',
        name: 'cancel',
        args: [],
        locale: locale.toString(),
      );
}

class TodoLocalizationsDelegate
    extends LocalizationsDelegate<TodoLocalizations> {
  @override
  Future<TodoLocalizations> load(Locale locale) =>
      TodoLocalizations.load(locale);

  @override
  bool shouldReload(TodoLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains('en');
}

class ProviderLocalizations {
  static ProviderLocalizations? of(BuildContext context) {
    return Localizations.of<ProviderLocalizations>(
        context, ProviderLocalizations);
  }

  String get appTitle => 'Todo: Manage your daily tasks';
}

class ProviderLocalizationsDelegate
    extends LocalizationsDelegate<ProviderLocalizations> {
  @override
  Future<ProviderLocalizations> load(Locale locale) =>
      Future(() => ProviderLocalizations());

  @override
  bool shouldReload(ProviderLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains('en');
}
