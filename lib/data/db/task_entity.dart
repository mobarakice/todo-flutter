import 'package:floor/floor.dart';

@Entity(tableName: 'Task')
class Task {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String description;
  final bool complete;

  Task(this.id, this.title, this.description, this.complete);

  @override
  int get hashCode =>
      complete.hashCode ^ title.hashCode ^ description.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          title == other.title &&
          description == other.description &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'complete': complete,
      'title': title,
      'description': description,
      'id': id ?? -1,
    };
  }

  @override
  String toString() {
    return 'TodoEntity{complete: $complete, task: $title, note: $description, id: $id}';
  }

  static Task fromJson(Map<String, Object> json) {
    return Task(
      json['id'] as int,
      json['title'] as String,
      json['description'] as String,
      json['complete'] as bool,
    );
  }

  Task copy(Task task, {var title, var complete, var description, var id}) =>
      Task(id ?? task.id, title ?? task.title, description ?? task.description,
          complete ?? task.complete);
}
