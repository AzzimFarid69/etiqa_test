import 'package:flutter/material.dart';
import 'package:todo_list/TodoList.dart';
import 'package:todo_list/utils/format_utils.dart';
import 'package:todo_list/utils/route_generator.dart';

class AddNewTodo extends StatefulWidget {
  const AddNewTodo({Key key}) : super(key: key);

  @override
  State<AddNewTodo> createState() => _AddNewTodoState();
}

class _AddNewTodoState extends State<AddNewTodo> {
  final now = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String initDate = '';
  DateTime selectedDate = DateTime.now().subtract(
    const Duration(days: 30),
  );
  DateTime selectedEndDate = DateTime.now().subtract(
    const Duration(days: 30),
  );
  final dateController = TextEditingController();
  final endDateController = TextEditingController();
  final titleController = TextEditingController();

  Future<Null> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(
        const Duration(days: 30),
      ),
      lastDate: DateTime(2099),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      print('selectedDate: $selectedDate');
      controller.text = FormatUtils.dateFormat(selectedDate.toString());
    }
  }

  Future<Null> _selectEndDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime endPickedDate = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: selectedDate.subtract(
        const Duration(days: 30),
      ),
      lastDate: DateTime(2099),
    );
    if (endPickedDate != null && endPickedDate != selectedEndDate) {
      selectedEndDate = endPickedDate;
      controller.text = FormatUtils.dateFormat(selectedEndDate.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new To-Do List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.home);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                        top: 10.0,
                      ),
                      child: Text('To-Do-Title'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: TextFormField(
                        controller: titleController,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please key in title';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          hintText: 'Please key in your To-Do title here',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text('Start Date'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please key in start date';
                          }
                          return null;
                        },
                        controller: dateController,
                        readOnly: true,
                        onTap: () => _selectDate(context, dateController),
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          hintText: 'Select a Date',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text('End Date'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please key in end date';
                          }
                          return null;
                        },
                        controller: endDateController,
                        readOnly: true,
                        onTap: () {
                          _selectEndDate(context, endDateController);
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          hintText: 'Select a Date',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Map<String, Object> res = new Map();
                  res.putIfAbsent('title', () => titleController.text);
                  res.putIfAbsent('startDate', () => selectedDate.toString());
                  res.putIfAbsent('endDate', () => selectedEndDate.toString());
                  print('res: $res');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TodoList(
                        response: res,
                      ),
                    ),
                  );
                }
              },
              child: Text('Create Now'),
            ),
          ],
        ),
      ),
    );
  }
}
