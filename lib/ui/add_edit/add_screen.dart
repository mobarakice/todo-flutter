import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_list_model.dart';
import 'package:todo/utils/keys.dart';

import '../../data/db/task_entity.dart';
import '../../localizations/localization.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen() : super(key: TodoKeys.addTodoScreen);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleEditingController = TextEditingController();
  final _notesEditingController = TextEditingController();

  @override
  void dispose() {
    _titleEditingController.dispose();
    _notesEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = TodoLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(localizations!.addTask),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                key: TodoKeys.taskField,
                controller: _titleEditingController,
                decoration: InputDecoration(
                  hintText: localizations.newTodoHint,
                ),
                style: textTheme.titleMedium,
                autofocus: true,
                validator: (val) {
                  return val!.trim().isEmpty
                      ? localizations.emptyTaskError
                      : null;
                },
              ),
              TextFormField(
                key: TodoKeys.noteField,
                controller: _notesEditingController,
                style: textTheme.titleSmall,
                decoration:
                    InputDecoration(hintText: localizations.descriptionHint),
                maxLines: 15,
              ),
              const SizedBox(height: 8),
              SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                      key: TodoKeys.saveNewTodo,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Provider.of<TodoListModel>(context, listen: false)
                              .addTodo(Task(
                            null,
                            _titleEditingController.text,
                            _notesEditingController.text,
                            false
                          ));
                          Navigator.pop(context);
                        }
                      },
                      child: Text(localizations.addTask,
                          style: textTheme.titleLarge)))
            ],
          ),
        ),
      ),
    );
  }
}
