import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perpustakaan_app/database/database_helper.dart';
import 'package:perpustakaan_app/service/api_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

final databaseProvider = Provider<DatabaseHelper>((ref) {
  return DatabaseHelper();
});
