import 'package:flutter_application_1/model/book_model.dart';

enum SortingCriteria { alphabetical, count }

class SortingHelper {
  static void sortBooks(List<Book> books, SortingCriteria criteria) {
    switch (criteria) {
      case SortingCriteria.alphabetical:
        _sortByAlphabetical(books);
        break;
      case SortingCriteria.count:
        _sortByCount(books);
        break;
    }
  }

  static void _sortByAlphabetical(List<Book> books) {
    books.sort((a, b) => a.title.compareTo(b.title));
  }

  static void _sortByCount(List<Book> books) {
    books.sort((a, b) => a.title.length.compareTo(b.title.length));
  }
}
