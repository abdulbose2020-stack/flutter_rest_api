import 'package:http/http.dart' as http;
import 'dart:convert';
import 'todo.dart';

class ApiService {
  final String baseUrl =
      'https://jsonplaceholder.typicode.com';

  Uri getTodoUrl(int id) {
    return Uri.parse(
      '$baseUrl/todos/$id',
    );
  }

  Future<dynamic> _getRequest(Uri url) async {
    final response = await http.get(url);

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      final data = jsonDecode(response.body);

      return data;
    }

    final errorData = response.body;

    throw Exception(
      'GET request failed: ${response.statusCode} $errorData',
    );
  }

  Future<Todo> fetchTodo(int id) async {
    final url = getTodoUrl(id);

    final Map<String, dynamic> data =
        await _getRequest(url);

    return Todo.fromJson(data);
  }

  Future<List<Todo>> fetchTodos() async {
    final url = Uri.parse(
      '$baseUrl/todos',
    );

    final response = await _getRequest(url);

    final List<Map<String, dynamic>> data =
        response.cast<Map<String, dynamic>>();

    return data
        .map((json) => Todo.fromJson(json))
        .toList();
  }

  Future<Todo> createTodo({
    required int userId,
    required String title,
    required bool completed,
  }) async {
    final url = Uri.parse('$baseUrl/todos');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': userId,
        'title': title,
        'completed': completed,
      }),
    );

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      final data = jsonDecode(response.body);

      return Todo.fromJson(data);
    }

    throw Exception(
      'POST request failed: ${response.statusCode}',
    );
  }

  Future<Todo> updateTodo({
    required int id,
    required int userId,
    required String title,
    required bool completed,
  }) async {
    final url = Uri.parse('$baseUrl/todos/$id');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': userId,
        'title': title,
        'completed': completed,
      }),
    );

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      final data = jsonDecode(response.body);

      return Todo.fromJson(data);
    }

    throw Exception(
      'PUT request failed: ${response.statusCode}',
    );
  }

  Future<void> deleteTodo (int id) async {
    final url = Uri.parse('$baseUrl/todos/$id');
    final response = await http.delete(
      url,
    );

    if(response.statusCode >= 200 &&
    response.statusCode < 300) {
      return;
    }

    throw Exception(
      'Delete request failed: ${response.statusCode}',
    );
  }
}