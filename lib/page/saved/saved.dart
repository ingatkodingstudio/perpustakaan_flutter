import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perpustakaan_app/model/book.dart';
import 'package:perpustakaan_app/model/data_state.dart';
import 'package:perpustakaan_app/provider/saved_book_notifier.dart';

class Saved extends ConsumerStatefulWidget {
  const Saved({super.key});

  @override
  ConsumerState<Saved> createState() => _SavedState();
}

class _SavedState extends ConsumerState<Saved> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(savedBookNotifierProvider.notifier).getBook();
  }

  @override
  Widget build(BuildContext context) {
    final dummyBook = Book(id: 0, title: '', author: '');
    final dummyBooks = List.generate(3, (index) => dummyBook);

    final state = ref.watch(savedBookNotifierProvider);

    switch (state) {
      case Loading():
        return _generateListBook(dummyBooks);
      case EmptyData():
        return const SizedBox(
          height: 190,
          child: Center(child: Text('No Data')),
        );
      case Error(message: var message, retry: var retry):
        return SizedBox(
          height: 190,
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(message),
              retry != null
                  ? TextButton(
                      onPressed: () {
                        retry();
                      },
                      child: const Text('Retry'))
                  : Container()
            ]),
          ),
        );
      case Success(data: var data):
        return _generateListBook(data);
      case InitialState():
        return _generateListBook(dummyBooks);
    }
  }

  Widget _generateListBook(List<Book> books) {
    return ListView.separated(
      itemCount: books.length,
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) => Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[400],
      ),
      itemBuilder: (context, index) {
        final book = books[index];

        return Dismissible(
          key: Key(book.id.toString()),
          onDismissed: (direction) {
            ref.watch(savedBookNotifierProvider.notifier).removeBook(book);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.blueGrey,
                  width: 50,
                  height: 60,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      book.author,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
