import 'dart:io';

import 'package:dio/dio.dart';
import 'package:perpustakaan_app/model/book.dart';

class ApiService {
  final Dio _dio;

  final String _baseUrl = 'https://library.ingatkoding.com/';
  final String _bookPath = 'book';

  ApiService(this._dio);

  Future<List<Book>> fetchBooks() async {
    final endpoint = _baseUrl + _bookPath;

    final response = await _dio.get(endpoint);

    if (response.statusCode != null &&
        response.statusCode.toString()[0] == '2') {
      final data = response.data!;

      return Book.toBooks(_decodeData(data));
    } else {
      throw HttpException("${response.statusCode} fail to fetch data");
    }
  }

  List<Map<String, dynamic>> _decodeData(List<dynamic> data) {
    return List<Map<String, dynamic>>.from(data);
  }
}
