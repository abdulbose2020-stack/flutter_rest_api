import 'package:flutter/material.dart';
import 'package:flutter_rest_api/todo.dart';
import 'api_service.dart';

Future<void> main() async {
  final apiService = ApiService();
  final todo = await apiService.fetchTodo(1);

  print(todo.title);
  print(todo.completed);

  final todos = await apiService.fetchTodos();

  print(todos.length);
  print(todos[0].title);
  
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('REST API Practice'),
        ),
      ),
    );
  }
}