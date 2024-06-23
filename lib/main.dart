import 'package:flutter/material.dart';
import 'package:flutter_application_1/business%20logic/book_provider.dart';
import 'package:flutter_application_1/presentation/book_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BookProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book List App',
      home: BookListScreen(),
    );
  }
}
