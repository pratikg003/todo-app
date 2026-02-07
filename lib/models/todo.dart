class Todo {
  final String title;
  final String id;
  bool isDone;

  Todo({required this.title, required this.id, required this.isDone});

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'isDone': isDone};
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(title: json['title'], id: json['id'], isDone: json['isDone']);
  }
}
