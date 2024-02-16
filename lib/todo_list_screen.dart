
import 'package:flutter/material.dart';
import 'package:flutter_test_app/model/task.dart';

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final List<Task> _tasks = [];

  void _addTask(String title) {
    setState(() {
      _tasks.add(Task(title: title));
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _toggleComplete(int index) {
    setState(() {
      _tasks[index].toggleComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];

          return ListTile(
            title: Text(task.title,style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeTask(index),
            ),
            onTap: () => _toggleComplete(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child:   Icon(Icons.add),
        onPressed: () {
          TextEditingController taskController = TextEditingController();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("新しいタスクを追加"),
                  content: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                        hintText: "タスクのタイトルを入力してください"),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text("キャンセル"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: Text("追加"),
                      onPressed: () {
                        if (taskController.text.isNotEmpty) {
                          _addTask(taskController.text);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                );
              }
          );

        }

    ),
    );
  }
}
