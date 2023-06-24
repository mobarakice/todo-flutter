import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models.dart';
import '../../models/todo_list_model.dart';
import '../../utils/keys.dart';
import '../details/details_screen.dart';

class TodoListView extends StatelessWidget {
  final void Function(BuildContext context, Task todo) onRemove;

  const TodoListView({required this.onRemove, super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<TodoListModel, List<Task>>(
      selector: (_, model) => model.filteredTodos,
      builder: (context, todos, _) {
        return ListView.builder(
          //key: key: TodoKeys.todoList,
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];

            return Dismissible(
              key: TodoKeys.todoItem(todo.id),
              onDismissed: (_) => onRemove(context, todo),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return DetailsScreen(
                          id: todo.id,
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
                  key: TodoKeys.todoItemCheckbox(todo.id),
                  value: todo.complete,
                  onChanged: (complete) {
                    Provider.of<TodoListModel>(context, listen: false)
                        .updateTodo(todo.copy(complete: complete));
                  },
                ),
                title: Text(
                  todo.title,
                  key: TodoKeys.todoItemTask(todo.id),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  todo.description,
                  key: TodoKeys.todoItemNote(todo.id),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
