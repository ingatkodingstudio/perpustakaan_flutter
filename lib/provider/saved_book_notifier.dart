import 'package:perpustakaan_app/model/book.dart';
import 'package:perpustakaan_app/model/data_state.dart';
import 'package:perpustakaan_app/provider/app_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_book_notifier.g.dart';

@riverpod
class SavedBookNotifier extends _$SavedBookNotifier {
  @override
  DataState<List<Book>> build() {
    return InitialState();
  }

  Future<void> saveOrRemove(Book book) async {
    try {
      final db = ref.watch(databaseProvider);
      final existing = await db.getBook(book);

      if (existing != null) {
        await db.delete(book);
      } else {
        await db.insertBook(book);
      }
    } catch (e) {
      state = Error(e.toString());
    }
  }

  Future<void> getBook() async {
    try {
      final db = ref.watch(databaseProvider);

      final data = await db.getBooks();

      if (data.isNotEmpty) {
        state = Success(data);
      } else {
        state = EmptyData();
      }
    } catch (e) {
      state = Error(e.toString());
    }
  }

  Future<void> removeBook(Book book) async {
    try {
      final db = ref.watch(databaseProvider);
      await db.delete(book);
    } catch (e) {
      state = Error(e.toString());
    }
  }
}
