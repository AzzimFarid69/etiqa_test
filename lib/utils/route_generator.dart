import 'package:flutter/material.dart';
import 'package:todo_list/add_new_todo.dart';

import '../TodoList.dart';

class Routes {
  static const String home = '/';
  static const String addTodo = '/addTodo';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        {
          Map map = settings.arguments;
          print('map: $settings.arguments');
          return MaterialPageRoute(
            builder: (_) => TodoList(
              response: map,
            ),
          );
        }
      case Routes.addTodo:
        return MaterialPageRoute(builder: (_) => const AddNewTodo());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(
            child: Text('Error'),
          ),
        );
      },
    );
  }
}
