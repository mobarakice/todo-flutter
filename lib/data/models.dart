import 'package:todo/data/db/task_entity.dart';
import 'package:todo/utils/uuid.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final bool complete;

  Task(this.title, {this.complete = false, this.description = '', var id})
      : id = id ?? Uuid().generateV4();

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

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, note: $description, complete: $complete}';
  }

  TaskEntity toEntity() {
    return TaskEntity(title, id, description, complete);
  }

  static Task fromEntity(TaskEntity entity) {
    return Task(
      entity.title,
      complete: entity.complete,
      description: entity.description,
      id: entity.id,
    );
  }

  Task copy({var title, var complete, var description, var id}) {
    return Task(
      title ?? this.title,
      complete: complete ?? this.complete,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }
}
