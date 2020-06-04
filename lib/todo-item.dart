class TodoItem {
  String title;
  bool completed;

  TodoItem({
    this.title,
    this.completed = false,
  });

  TodoItem.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        completed = map['completed'];

  updateTitle(title) {
    this.title = title;
  }

  Map toMap() {
    return {
      'title': title,
      'completed': completed,
    };
  }
}
