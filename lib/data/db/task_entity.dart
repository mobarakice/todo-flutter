class TaskEntity {
  final String id;
  final String title;
  final String description;
  final bool complete;

  TaskEntity(this.title, this.id, this.description, this.complete);

  @override
  int get hashCode =>
      complete.hashCode ^ title.hashCode ^ description.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskEntity &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          title == other.title &&
          description == other.description &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'complete': complete,
      'task': title,
      'note': description,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'TodoEntity{complete: $complete, task: $title, note: $description, id: $id}';
  }

  static TaskEntity fromJson(Map<String, Object> json) {
    return TaskEntity(
      json['task'] as String,
      json['id'] as String,
      json['note'] as String,
      json['complete'] as bool,
    );
  }
}
