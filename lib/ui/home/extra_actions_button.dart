import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils/widgets.dart';

import '../../localizations/localization.dart';
import '../../models/todo_list_model.dart';
import '../../utils/keys.dart';

class ExtraActionsButton extends StatelessWidget {
  const ExtraActionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
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
            key: TodoKeys.toggleAll,
            value: ExtraAction.toggleAllComplete,
            child: Text(_activeText(model, context)),
          ),
          PopupMenuItem<ExtraAction>(
            key: TodoKeys.clearCompleted,
            value: ExtraAction.clearCompleted,
            child: Text(TodoLocalizations.of(context)!.clearCompleted),
          ),
        ];
      },
    );
  }

  String _activeText(TodoListModel model, BuildContext context) {
    return model.hasActiveTodos
        ? TodoLocalizations.of(context)!.markAllComplete
        : TodoLocalizations.of(context)!.markAllIncomplete;
  }

  Widget _buildIos(BuildContext context) {
    final model = Provider.of<TodoListModel>(context);
    return Center(
            child: CupertinoContextMenu(
              actions: <Widget>[
                CupertinoContextMenuAction(
                  onPressed: () {
                    model.toggleAll();
                    Navigator.pop(context);
                  },
                  isDefaultAction: true,
                  child: Text(_activeText(model, context)),
                ),
                CupertinoContextMenuAction(
                  onPressed: () {
                    model.clearCompleted();
                    Navigator.pop(context);
                  },
                  child: Text(TodoLocalizations.of(context)!.clearCompleted),
                )
              ],
              child: const Icon(Icons.more_vert, color: Colors.grey,)
            ));
  }
}

enum ExtraAction { toggleAllComplete, clearCompleted }
