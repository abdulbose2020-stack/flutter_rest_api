import 'package:flutter/material.dart';
import 'package:flutter_rest_api/todo.dart';
import 'api_service.dart';

Future<void> main() async {
  final apiService = ApiService();

  final todo = await apiService.fetchTodo(1);

  print(todo.title);
  print(todo.completed);

  final todos = await apiService.fetchTodos();

  for (Todo todo in todos) {
    print(
      'ID: ${todo.id}, '
      'Title: ${todo.title}, '
      'Completed: ${todo.completed}',
    );
  }

  final newTodo = await apiService.createTodo(
    userId: 1,
    title: 'Learn Flutter Rest API',
    completed: false,
  );

  print(newTodo.id);
  print(newTodo.title);
  print(newTodo.completed);

  final updatedTodo = await apiService.updateTodo(
    id: 1,
    userId: 1,
    title: 'Updated Flutter REST API',
    completed: true,
  );

  print(updatedTodo.id);
  print(updatedTodo.title);
  print(updatedTodo.completed);

  await apiService.deleteTodo(1);
  print('Todo deleted successfully');

  final List<Todo> completedTodos = [];

  for (Todo todo in todos) {
    if (todo.completed) {
      completedTodos.add(todo);
    }
  }

  print(completedTodos[0].id);
  print(completedTodos[1].title);
  print(completedTodos[2].completed);

  print(completedTodos.length);
  print(completedTodos);

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