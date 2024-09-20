import 'dart:convert';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  int id;
  String title;
  String author;

  Book({
    required this.id,
    required this.title,
    required this.author,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        author: json["author"],
      );

  static List<Book> toBooks(List<Map<String, dynamic>> maps) =>
      maps.map((value) => Book.fromJson(value)).toList();

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
      };
}
