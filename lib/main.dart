import 'package:flutter/material.dart';
import 'api_service.dart';

Future<void> main() async {
  final apiService = ApiService();
  final todo = await apiService.fetchTodo(1);

  print(todo.title);
  print(todo.completed);

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