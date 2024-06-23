import 'dart:convert';
import 'package:flutter_application_1/model/book_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'https://freetestapi.com/api/v1/books';
  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Book> books = jsonResponse.map((item) => Book.fromJson(item)).toList();
      return books;
    } else {
      throw Exception('Failed to load books');
    }
  }
}
