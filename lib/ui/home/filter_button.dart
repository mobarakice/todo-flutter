import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils/widgets.dart';

import '../../localizations/localization.dart';
import '../../models/todo_list_model.dart';

class FilterButton extends StatelessWidget {
  final bool isActive;

  const FilterButton({required this.isActive, super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
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

  Widget _buildAndroid(BuildContext context) {
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

  Widget _buildIos(BuildContext context) {
    final model = Provider.of<TodoListModel>(context);
    return Container(
      alignment: Alignment.topRight,
      child: Center(
          child: CupertinoContextMenu.builder(
            actions: [
              CupertinoContextMenuAction(
                onPressed: () {
                  model.toggleAll();
                  Navigator.pop(context);
                },
                isDefaultAction: true,
                child: Text(TodoLocalizations.of(context)!.showAll),
              ),
              CupertinoContextMenuAction(
                onPressed: () {
                  model.clearCompleted();
                  Navigator.pop(context);
                },
                child: Text(TodoLocalizations.of(context)!.showActive),
              ),
              CupertinoContextMenuAction(
                onPressed: () {
                  model.clearCompleted();
                  Navigator.pop(context);
                },
                child: Text(TodoLocalizations.of(context)!.showCompleted),
              )
            ],
            builder: (BuildContext context, Animation<double> animation) {
              final Animation<Decoration> boxDecorationAnimation =
                  _boxDecorationAnimation(animation);

              return Container(
                decoration: animation.value < CupertinoContextMenu.animationOpensAt
                    ? boxDecorationAnimation.value
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemCyan,
                    borderRadius: BorderRadius.circular(20.0),
                  )
                ),
              );//return const Text("");
            },
          )),
    );
  }

  // Or just do this inline in the builder below?
  static Animation<Decoration> _boxDecorationAnimation(
      Animation<double> animation) {
    return _tween.animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(
          0.0,
          CupertinoContextMenu.animationOpensAt,
        ),
      ),
    );
  }
}

final DecorationTween _tween = DecorationTween(
  begin: BoxDecoration(
    color: CupertinoColors.systemYellow,
    boxShadow: const <BoxShadow>[],
    borderRadius: BorderRadius.circular(20.0),
  ),
  end: BoxDecoration(
    color: CupertinoColors.systemYellow,
    boxShadow: CupertinoContextMenu.kEndBoxShadow,
    borderRadius: BorderRadius.circular(20.0),
  ),
);
