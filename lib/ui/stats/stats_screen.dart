import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localizations/localization.dart';
import '../../models/todo_list_model.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              TodoLocalizations.of(context)!.completedTasks,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Selector<TodoListModel, int>(
              selector: (_, model) => model.numCompleted,
              builder: (context, numCompleted, _) => Text(
                '$numCompleted',
                //key: key: TodoKeys.statsNumCompleted,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              TodoLocalizations.of(context)!.activeTasks,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Selector<TodoListModel, int>(
              selector: (_, model) => model.numActive,
              builder: (context, numActive, _) => Text(
                '$numActive',
                //key: key: TodoKeys.statsNumActive,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          )
        ],
      ),
    );
  }
}
