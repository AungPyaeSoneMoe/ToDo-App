import 'package:flutter/material.dart';
import 'package:todo_app/config/todo_list.dart';
import 'package:todo_app/data/todo_model.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.todo, this.onDone, this.deleteDone});
  final TodoModel todo;
  final void Function()? onDone;
  final void Function()? deleteDone;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<TodoModel> tempTodoList = TodoList.todos;
  final today = DateTime.now();
  bool inDoneTask = false;
  final List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  String weekDayToDay(int index) {
    return days[index];
  }

  // for editButton method
  void _editTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: AlertDialog(
            title: const Text('Edit Task'),
            content: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                      prefixIcon: Icon(
                        Icons.title,
                        color: Colors.orange,
                      ),
                    ),
                    validator: (String? val) {
                      if (val == null || val == '') return 'Title is required!';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    minLines: 1,
                    maxLines: null,
                    decoration: const InputDecoration(
                      label: Text('Description'),
                      prefixIcon: Icon(
                        Icons.description,
                        color: Colors.orange,
                      ),
                    ),
                    validator: (String? val) {
                      if (val == null || val == '') {
                        return 'Description is required!';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Edit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      widget.todo.title = _titleController.text;
                      widget.todo.description = _descriptionController.text;
                      Navigator.pop(context);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widget.todo.isDone ? 14 : 6),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.orange.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        widget.todo.title,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      widget.todo.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ],
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                  ),
                  onPressed: widget.deleteDone,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    widget.todo.date,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    widget.todo.time,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (!widget.todo.isDone) ...[
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                  ),
                  iconSize: 14,
                  onPressed: () {
                    _editTask();

                    /// ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️ Assignment 1
                    /// TODO: edit function here
                    /// Edit with dialog or route to edit page
                    /// TODO: implement delete function yourself
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.green.shade100,
                  ),
                  onPressed: widget.onDone,
                  icon: const Icon(
                    Icons.task_alt,
                    color: Colors.green,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
