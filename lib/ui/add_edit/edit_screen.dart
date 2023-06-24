import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localizations/localization.dart';
import '../../models/todo_list_model.dart';
import '../../utils/keys.dart';

class EditTaskScreen extends StatefulWidget {
  final void Function(String task, String note) onEdit;
  final String id;

  const EditTaskScreen({
    required this.id,
    required this.onEdit,
  }) : super(key: TodoKeys.editTodoScreen);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _taskController;
  late TextEditingController _noteController;

  @override
  void initState() {
    final todo =
        Provider.of<TodoListModel>(context, listen: false).todoById(widget.id);
    _taskController = TextEditingController(text: todo.title);
    _noteController = TextEditingController(text: todo.description);
    super.initState();
  }

  @override
  void dispose() {
    _taskController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(TodoLocalizations.of(context)!.editTask)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _taskController,
                key: TodoKeys.taskField,
                style: Theme.of(context).textTheme.headlineMedium,
                decoration: InputDecoration(
                  hintText: TodoLocalizations.of(context)!.newTodoHint,
                ),
                validator: (val) {
                  var v = val ?? "";
                  return v.trim().isEmpty
                      ? TodoLocalizations.of(context)!.emptyTaskError
                      : null;
                },
              ),
              TextFormField(
                controller: _noteController,
                key: TodoKeys.noteField,
                decoration: InputDecoration(
                  hintText: TodoLocalizations.of(context)!.descriptionHint,
                ),
                maxLines: 10,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: TodoKeys.saveTodoFab,
        tooltip: TodoLocalizations.of(context)!.saveChanges,
        onPressed: () {
          if (_formKey.currentState != null &&
              _formKey.currentState!.validate()) {
            _formKey.currentState?.save();
            widget.onEdit(_taskController.text, _noteController.text);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
