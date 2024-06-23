import 'package:flutter/material.dart';
import 'package:flutter_application_1/business%20logic/book_provider.dart';
import 'package:flutter_application_1/business%20logic/sorting_helper.dart';
import 'package:flutter_application_1/model/book_model.dart';
import 'package:provider/provider.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
   State <BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
void initState() {
  super.initState();
  Future.microtask(() =>
    context.read<BookProvider>().fetchBooks()
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        actions: [
          Consumer<BookProvider>(
            builder: (context, provider, child) => DropdownButton<SortingCriteria>(
              value: provider.currentSortingCriteria,
              onChanged: (criteria) {
                provider.sortBooksBy(criteria!);
              },
              items: SortingCriteria.values
                  .map<DropdownMenuItem<SortingCriteria>>(
                      (criteria) => DropdownMenuItem<SortingCriteria>(
                            value: criteria,
                            child: Text(criteria.toString().split('.').last),
                          ))
                  .toList(),
            ),
          ),
        ],
      ),
      body: Consumer<BookProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Add a book',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          provider.addBook(Book(
                              id: DateTime.now().millisecondsSinceEpoch,
                              title: _controller.text));
                          _controller.clear();
                        }
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.books.length,
                  itemBuilder: (context, index) {
                    final book = provider.books[index];
                    return ListTile(
                      title: Text(book.title),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Confirm Delete'),
                              content:
                                  Text('Are you sure you want to delete ${book.title}?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    provider.removeBook(book);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
