import 'package:flutter/material.dart';
import 'package:todo_app/data/todo_model.dart';
import 'package:todo_app/widgets/task_card.dart';

import '../config/todo_list.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  final List<TodoModel> tempTodoList = TodoList.doneTodos;

  void deleteTask(int index) {
    setState(() {
      tempTodoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    /// if [TodoList.doneTodos] list is empty, show a text
    if (TodoList.doneTodos.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No tasks has been completed 🥺!'),
        ),
      );
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: TodoList.doneTodos.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            width: double.maxFinite,
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              children: [
                Expanded(
                    child: TaskCard(
                  todo: TodoList.doneTodos[index],
                  onDone: () {},
                  deleteDone: () {
                    deleteTask(index);
                  },
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}
