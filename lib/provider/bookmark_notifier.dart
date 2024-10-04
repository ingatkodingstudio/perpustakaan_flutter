import 'package:perpustakaan_app/model/book.dart';
import 'package:perpustakaan_app/model/data_state.dart';
import 'package:perpustakaan_app/provider/app_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_notifier.g.dart';

@riverpod
class BookmarkNotifier extends _$BookmarkNotifier {
  @override
  DataState<bool> build() {
    return InitialState();
  }

  Future<void> getBookmarkStatus(Book book) async {
    try {
      final db = ref.watch(databaseProvider);
      final bookmarked = await db.getBook(book);

      state = Success(bookmarked != null);
    } catch (e) {
      state = Error(e.toString());
    }
  }
}
