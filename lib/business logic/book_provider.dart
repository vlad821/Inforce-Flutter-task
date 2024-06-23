import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/book_model.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'sorting_helper.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];
  bool _isLoading = false;
  SortingCriteria _currentSortingCriteria = SortingCriteria.alphabetical;

  List<Book> get books => _books;
  bool get isLoading => _isLoading;
  SortingCriteria get currentSortingCriteria => _currentSortingCriteria;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void addBook(Book book) {
    if (book.title.isNotEmpty) {
      _books.add(book);
      _sortBooks();
      notifyListeners();
    }
  }

  void removeBook(Book book) {
    _books.remove(book);
    notifyListeners();
  }

  void sortBooksBy(SortingCriteria criteria) {
    _currentSortingCriteria = criteria;
    _sortBooks();
    notifyListeners();
  }

  Future<void> fetchBooks() async {
    setLoading(true);
    try {
      _books = await ApiService().fetchBooks(); // Fetch all books from ApiService
      _sortBooks();
    } catch (e) {
      print('Error fetching books: $e');
    } finally {
      setLoading(false);
    }
  }

  void _sortBooks() {
    SortingHelper.sortBooks(_books, _currentSortingCriteria);
  }
}
