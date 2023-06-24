import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_list_model.dart';

import '../../data/models.dart';
import '../../localizations/localization.dart';
import '../../utils/keys.dart';
import '../add_edit/edit_screen.dart';

class DetailsScreen extends StatelessWidget {
  final String id;
  final VoidCallback onRemove;

  const DetailsScreen({required this.id, required this.onRemove})
      : super(key: TodoKeys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TodoLocalizations.of(context)!.taskDetails),
        actions: <Widget>[
          IconButton(
            key: TodoKeys.deleteTodoButton,
            tooltip: TodoLocalizations.of(context)!.deleteTask,
            icon: const Icon(Icons.delete),
            onPressed: onRemove,
          )
        ],
      ),
      body: Selector<TodoListModel, Task>(
        selector: (context, model) => model.todoById(id),
        shouldRebuild: (prev, next) => true,
        builder: (context, todo, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Checkbox(
                        key: TodoKeys.detailsTodoItemCheckbox,
                        value: todo.complete,
                        onChanged: (complete) {
                          Provider.of<TodoListModel>(context, listen: false)
                              .updateTodo(todo.copy(complete: !todo.complete));
                        },
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 16.0,
                            ),
                            child: Text(
                              todo.title,
                              key: TodoKeys.detailsTodoItemTask,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          Text(
                            todo.description,
                            key: TodoKeys.detailsTodoItemNote,
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: TodoKeys.editTodoFab,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTaskScreen(
                id: id,
                onEdit: (title, description) {
                  final model =
                      Provider.of<TodoListModel>(context, listen: false);
                  final todo = model.todoById(id);

                  model.updateTodo(todo.copy(title: title, description: description));

                  return Navigator.pop(context);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
