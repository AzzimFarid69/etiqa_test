import 'package:flutter/material.dart';
import 'package:todo_list/model/Todo.dart';
import 'package:todo_list/utils/format_utils.dart';

class TodoItem extends StatelessWidget {
  TodoItem({
    this.todo,
    this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final onTodoChanged;

  TextStyle _getTextStyle(bool checked) {
    if (!checked) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(todo.name),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Text('Start Date'),
                        ),
                        Text(FormatUtils.dateFormat(todo.startDate.toString())),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Text('End Date'),
                        ),
                        Text(FormatUtils.dateFormat(todo.endDate.toString())),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Text('Time Left'),
                        ),
                        Text(FormatUtils.differentDate(
                            todo.startDate, todo.endDate)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.red,
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Status: '),
                    Text('Incomplete'),
                  ],
                ),
                Row(
                  children: [
                    Text('Tick if completed'),
                    Checkbox(value: todo.checked, onChanged: (bool value) {},),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
    // return ListTile(
    //   onTap: () {
    //     onTodoChanged(todo);
    //   },
    //   leading: CircleAvatar(
    //     child: Text(todo.name[0]),
    //   ),
    //   title: Text(todo.name, style: _getTextStyle(todo.checked)),
    // );
  }
}
