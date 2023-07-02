import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/home/extra_actions_button.dart';
import 'package:todo/ui/home/filter_button.dart';

import '../../data/db/task_entity.dart';
import '../../models/todo_list_model.dart';
import '../../utils/keys.dart';
import '../../utils/widgets.dart';
import '../details/details_screen.dart';

class TodoListView extends StatelessWidget {
  final void Function(BuildContext context, Task todo) onRemove;

  const TodoListView({required this.onRemove, super.key});

  Widget _buildIos(BuildContext context) {
    var tasks = context
        .select<TodoListModel, List<Task>>((model) => model.filteredTodos);
    return CustomScrollView(
      slivers: [
        const CupertinoSliverNavigationBar(
            trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              FilterButton(isActive: true),
              ExtraActionsButton()
            ])),
        SliverSafeArea(
          top: false,
          sliver: SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final task = tasks.elementAt(index);
                  return CupertinoListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return DetailsScreen(
                                id: task.id ?? -1,
                                onRemove: () {
                                  Navigator.pop(context);
                                  onRemove(context, task);
                                },
                              );
                            },
                          ),
                        );
                      },
                      leading: CupertinoCheckbox(
                        key: TodoKeys.todoItemCheckbox(task.id ?? -1),
                        value: task.complete,
                        onChanged: (complete) {
                          Provider.of<TodoListModel>(context, listen: false)
                              .updateTodo(task.copy(task, complete: complete));
                        },
                      ),
                      title: Text(
                        task.title,
                        key: TodoKeys.todoItemTask(task.id ?? -1),
                      ),
                      subtitle: Text(
                        task.description,
                        key: TodoKeys.todoItemNote(task.id ?? -1),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ));
                },
                childCount: tasks.length,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    var tasks = context
        .select<TodoListModel, List<Task>>((model) => model.filteredTodos);
    return ListView.builder(
      key: TodoKeys.todoList,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final todo = tasks.elementAt(index);

        return Dismissible(
          key: TodoKeys.todoItem(todo.id ?? -1),
          onDismissed: (_) => onRemove(context, todo),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return DetailsScreen(
                      id: todo.id ?? -1,
                      onRemove: () {
                        Navigator.pop(context);
                        onRemove(context, todo);
                      },
                    );
                  },
                ),
              );
            },
            leading: Checkbox(
              key: TodoKeys.todoItemCheckbox(todo.id ?? -1),
              value: todo.complete,
              onChanged: (complete) {
                Provider.of<TodoListModel>(context, listen: false)
                    .updateTodo(todo.copy(todo, complete: complete));
              },
            ),
            title: Text(
              todo.title,
              key: TodoKeys.todoItemTask(todo.id ?? -1),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              todo.description,
              key: TodoKeys.todoItemNote(todo.id ?? -1),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        );
      },
    );
  }
}
