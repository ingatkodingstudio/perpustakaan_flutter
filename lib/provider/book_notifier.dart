import 'package:perpustakaan_app/model/data_state.dart';
import 'package:perpustakaan_app/model/book.dart';
import 'package:perpustakaan_app/provider/app_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_notifier.g.dart';

@riverpod
class BookNotifier extends _$BookNotifier {
  @override
  DataState<List<Book>> build() {
    return InitialState();
  }

  Future<void> fetchData() async {
    try {
      if (state is Loading) return;

      Future.microtask(() {
        state = Loading();
      });

      final api = ref.watch(apiServiceProvider);
      final data = await api.fetchBooks();

      if (data.isNotEmpty) {
        state = Success(data);
      } else {
        state = EmptyData();
      }
    } catch (e) {
      state = Error(e.toString(), retry: fetchData);
    }
  }
}
