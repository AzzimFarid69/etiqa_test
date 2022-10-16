import 'package:flutter/material.dart';
import 'package:todo_list/TodoList.dart';
import 'package:todo_list/utils/route_generator.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do-List',
      initialRoute: Routes.home,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: TodoList(response: null,),
    );
  }
}
