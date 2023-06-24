import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localizations/localization.dart';
import '../../models/todo_list_model.dart';

class ExtraActionsButton extends StatelessWidget {
  const ExtraActionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TodoListModel>(context);

    return PopupMenuButton<ExtraAction>(
      // key: key: TodoKeys.extraActionsButton,
      onSelected: (action) {
        switch (action) {
          case ExtraAction.toggleAllComplete:
            model.toggleAll();
            break;
          case ExtraAction.clearCompleted:
            model.clearCompleted();
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuItem<ExtraAction>>[
          PopupMenuItem<ExtraAction>(
            // key: key: TodoKeys.toggleAll,
            value: ExtraAction.toggleAllComplete,
            child: Text(model.hasActiveTodos
                ? TodoLocalizations.of(context)!.markAllComplete
                : TodoLocalizations.of(context)!.markAllIncomplete),
          ),
          PopupMenuItem<ExtraAction>(
            //key: key: TodoKeys.clearCompleted,
            value: ExtraAction.clearCompleted,
            child: Text(TodoLocalizations.of(context)!.clearCompleted),
          ),
        ];
      },
    );
  }
}

enum ExtraAction { toggleAllComplete, clearCompleted }
