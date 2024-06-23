class Book {
  final int id;
  final String title;

  Book({required this.id, required this.title});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
    );
  }
}
