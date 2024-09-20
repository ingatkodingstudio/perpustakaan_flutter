import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perpustakaan_app/model/book.dart';
import 'package:perpustakaan_app/model/data_state.dart';
import 'package:perpustakaan_app/provider/book_notifier.dart';

class TabWidget extends ConsumerStatefulWidget {
  const TabWidget({super.key});

  @override
  ConsumerState<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends ConsumerState<TabWidget> {
  @override
  void initState() {
    super.initState();
    ref.read(bookNotifierProvider.notifier).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final bookState = ref.watch(bookNotifierProvider);

    return Container(
      alignment: Alignment.center,
      child: DefaultTabController(
        length: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 30,
              child: TabBar(
                dividerHeight: 0,
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text(
                      'New Arrivals',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Popular',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Upcoming',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 230,
              child: TabBarView(
                children: [
                  _booksWidget(bookState),
                  const Center(
                    child: Text('Popular'),
                  ),
                  const Center(
                    child: Text('Upcoming'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _booksWidget(DataState<List<Book>> bookState) {
    final dummyBook = Book(id: 0, title: '', author: '');
    final dummyBooks = List.generate(3, (index) => dummyBook);

    switch (bookState) {
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
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(
        width: 12,
      ),
      itemBuilder: (context, index) {
        final book = books[index];

        return Padding(
          padding: EdgeInsets.only(
              left: index == 0 ? 16 : 0,
              right: index == books.length - 1 ? 16 : 0),
          child: SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.blueGrey,
                  width: 150,
                  height: 190,
                ),
                Text(
                  book.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      book.author,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
