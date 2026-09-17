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

  Future<Map<String, dynamic>> _getRequest(Uri url) async {
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
}