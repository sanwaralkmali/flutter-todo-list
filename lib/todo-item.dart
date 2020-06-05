class TodoItem {
  int id;
  String title;
  bool completed;

  TodoItem({
    this.id,
    this.title,
    this.completed = false,
  });

  TodoItem.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        completed = map['completed'];

  updateTitle(title) {
    this.title = title;
  }

  Map toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
