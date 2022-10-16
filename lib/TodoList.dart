import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/model/Todo.dart';
import 'package:todo_list/utils/format_utils.dart';
import 'package:todo_list/utils/route_generator.dart';
import 'package:todo_list/widget/TodoItem.dart';

class TodoList extends StatefulWidget {
  Map response;

  TodoList({
    Key key,
    this.response,
  }) : super(key: key);

  @override
  _TodoListState createState() => new _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<Todo> _todos = <Todo>[];
  var inputFormat = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    print('response: ${widget.response}');
    init();
    super.initState();
  }

  void init() {
    if (widget.response != null) {
      setState(
        () {
          _todos.add(
            Todo(
                name: widget.response['title'],
                startDate: widget.response['startDate'],
                endDate: widget.response['endDate'],
                checked: false),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo list'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _handleTodoChange,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.addTodo);
          },
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, checked: false));
    });
    _textFieldController.clear();
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new todo item'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your new todo'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (_textFieldController.text.isNotEmpty) {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
