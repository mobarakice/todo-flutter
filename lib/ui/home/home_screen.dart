import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:provider/provider.dart';

import '../../data/db/task_entity.dart';
import '../../localizations/localization.dart';
import '../../models/todo_list_model.dart';
import '../../utils/keys.dart';
import '../../utils/routes.dart';
import '../../utils/widgets.dart';
import '../stats/stats_screen.dart';
import '../tasks/tasks_screen.dart';
import 'extra_actions_button.dart';
import 'filter_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Because the state of the tabs is only a concern to the HomeScreen Widget,
  // it is stored as local state rather than in the TodoListModel.
  final _tab = ValueNotifier(_HomeScreenTab.todos);

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  Widget _buildAndroidHomePage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProviderLocalizations.of(context)?.appTitle as String),
        actions: <Widget>[
          ValueListenableBuilder<_HomeScreenTab>(
            valueListenable: _tab,
            builder: (_, tab, __) => FilterButton(
              isActive: tab == _HomeScreenTab.todos,
            ),
          ),
          const ExtraActionsButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: TodoKeys.addTodoFab,
        onPressed: () => Navigator.pushNamed(context, TodoRoutes.addTodo),
        tooltip: TodoLocalizations.of(context)?.addTask,
        child: const Icon(Icons.add),
      ),
      body: Selector<TodoListModel, bool>(
        selector: (context, model) => model.isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                  //key: key: TodoKeys.todosLoading,
                  ),
            );
          }

          return ValueListenableBuilder<_HomeScreenTab>(
            valueListenable: _tab,
            builder: (context, tab, _) {
              switch (tab) {
                case _HomeScreenTab.stats:
                  return const StatsView();
                case _HomeScreenTab.todos:
                default:
                  return TodoListView(
                    onRemove: (context, todo) {
                      Provider.of<TodoListModel>(context, listen: false)
                          .removeTodo(todo);
                      _showUndoSnackBar(context, todo);
                    },
                  );
              }
            },
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<_HomeScreenTab>(
        valueListenable: _tab,
        builder: (context, tab, _) {
          return BottomNavigationBar(
            key: TodoKeys.tabs,
            currentIndex: _HomeScreenTab.values.indexOf(tab),
            onTap: (int index) => _tab.value = _HomeScreenTab.values[index],
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "Tasks",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart),
                label: "Stats",
              ),
            ],
          );
        },
      ),
    );
  }

  // On iOS, the app uses a bottom tab paradigm. Here, each tab view sits inside
  // a tab in the tab scaffold. The tab scaffold also positions the tab bar
  // in a row at the bottom.
  //
  // An important thing to note is that while a Material Drawer can display a
  // large number of items, a tab bar cannot. To illustrate one way of adjusting
  // for this, the app folds its fourth tab (the settings page) into the
  // third tab. This is a common pattern on iOS.
  Widget _buildIosHomePage(BuildContext context) {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: false,
      tabBar: CupertinoTabBar(
        currentIndex: _HomeScreenTab.values.indexOf(_tab.value),
        onTap: (int index) => _tab.value = _HomeScreenTab.values[index],
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label:  TodoLocalizations.of(context)!.tasks,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.show_chart),
            label: TodoLocalizations.of(context)!.stats,
          )
        ],
      ),
      tabBuilder: (context, index) {
        assert(index <= 2 && index >= 0, 'Unexpected tab index: $index');
        return switch (index) {
          0 => CupertinoTabView(
              defaultTitle: TodoLocalizations.of(context)!.tasks,
              builder: (context) => TodoListView(onRemove: (context, todo) {
                Provider.of<TodoListModel>(context, listen: false)
                    .removeTodo(todo);
                _showUndoSnackBar(context, todo);
              }),
            ),
          1 => CupertinoTabView(
              defaultTitle: TodoLocalizations.of(context)!.stats, builder: (context) => const StatsView()),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroidHomePage,
      iosBuilder: _buildIosHomePage,
    );
  }

  void _showUndoSnackBar(BuildContext context, Task todo) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: TodoKeys.snackBar,
        duration: const Duration(seconds: 2),
        content: Text(
          TodoLocalizations.of(context)!.taskDeleted(todo.title),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        action: SnackBarAction(
          key: TodoKeys.snackBarAction(todo.id ?? -1),
          label: TodoLocalizations.of(context)!.undo,
          onPressed: () =>
              Provider.of<TodoListModel>(context, listen: false).addTodo(todo),
        ),
      ),
    );
  }
}

enum _HomeScreenTab { todos, stats }
