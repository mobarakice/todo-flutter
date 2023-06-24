import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localizations/localization.dart';
import '../../models/todo_list_model.dart';

class FilterButton extends StatelessWidget {
  final bool isActive;

  const FilterButton({required this.isActive, super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isActive,
      child: AnimatedOpacity(
        opacity: isActive ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 150),
        child: Consumer<TodoListModel>(
          builder: (context, model, _) {
            return PopupMenuButton<VisibilityFilter>(
              //key: key: TodoKeys.filterButton,
              tooltip: TodoLocalizations.of(context)!.filterTasks,
              initialValue: model.filter,
              onSelected: (filter) => model.filter = filter,
              itemBuilder: (BuildContext context) => _items(context, model),
              icon: const Icon(Icons.filter_list),
            );
          },
        ),
      ),
    );
  }

  List<PopupMenuItem<VisibilityFilter>> _items(
      BuildContext context, TodoListModel store) {
    final activeStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(color: Theme.of(context).hintColor);
    final defaultStyle = Theme.of(context).textTheme.bodyMedium;

    return [
      PopupMenuItem<VisibilityFilter>(
        //key: key: TodoKeys.allFilter,
        value: VisibilityFilter.all,
        child: Text(
          TodoLocalizations.of(context)!.showAll,
          style:
              store.filter == VisibilityFilter.all ? activeStyle : defaultStyle,
        ),
      ),
      PopupMenuItem<VisibilityFilter>(
        //key: key: TodoKeys.activeFilter,
        value: VisibilityFilter.active,
        child: Text(
          TodoLocalizations.of(context)!.showActive,
          style: store.filter == VisibilityFilter.active
              ? activeStyle
              : defaultStyle,
        ),
      ),
      PopupMenuItem<VisibilityFilter>(
        //key: key: TodoKeys.completedFilter,
        value: VisibilityFilter.completed,
        child: Text(
          TodoLocalizations.of(context)!.showCompleted,
          style: store.filter == VisibilityFilter.completed
              ? activeStyle
              : defaultStyle,
        ),
      ),
    ];
  }
}
