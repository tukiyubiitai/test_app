class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  void toggleComplete() {
    isCompleted = !isCompleted;
  }
}
