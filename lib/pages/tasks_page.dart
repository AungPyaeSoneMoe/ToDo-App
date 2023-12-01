import 'package:flutter/material.dart';

import '../config/todo_list.dart';
import '../data/todo_model.dart';
import '../widgets/task_card.dart';

class TasksPage extends StatelessWidget {
  const TasksPage(
      {super.key,
      required this.todoList,
      required this.onTodoDone,
      required this.onDeleteDone});
  final List<TodoModel> todoList;
  final Function(TodoModel) onTodoDone;
  final Function(TodoModel) onDeleteDone;
  @override
  Widget build(BuildContext context) {
    /// if [TodoList.todos] list is empty, show a text
    if (TodoList.todos.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('Create a Todo Task 📃!'),
        ),
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            todoList.length,
            (index) {
              return TaskCard(
                todo: todoList[index],
                onDone: () => onTodoDone(todoList[index]),
                deleteDone: () => onDeleteDone(todoList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
