import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perpustakaan_app/model/book.dart';
import 'package:perpustakaan_app/model/data_state.dart';
import 'package:perpustakaan_app/provider/bookmark_notifier.dart';
import 'package:perpustakaan_app/provider/saved_book_notifier.dart';

class Detail extends ConsumerStatefulWidget {
  final Book book;

  const Detail({super.key, required this.book});

  @override
  ConsumerState<Detail> createState() => _DetailState();
}

class _DetailState extends ConsumerState<Detail> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getBookmarkStatus();
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkState = ref.watch(bookmarkNotifierProvider);

    Widget iconBookmark;

    switch (bookmarkState) {
      case Success<bool>(data: var data):
        if (data) {
          iconBookmark = const Icon(Icons.bookmark);
        } else {
          iconBookmark = const Icon(Icons.bookmark_add_outlined);
        }
      case InitialState<bool>():
        iconBookmark = const CircularProgressIndicator();
      case EmptyData<bool>():
        iconBookmark = const Icon(Icons.bookmark_add_outlined);
      case Error<bool>():
        iconBookmark = const Icon(Icons.bookmark_add_outlined);
      case Loading<bool>():
        iconBookmark = const Icon(Icons.bookmark_add_outlined);
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 200,
            height: 250,
            child: Image.network(
              'https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg',
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.book.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            widget.book.author,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 18,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 100,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.adb),
                    Text('Category'),
                  ],
                ),
              ),
              const SizedBox(
                width: 100,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star),
                    Text('4.8 Rating'),
                  ],
                ),
              ),
              const SizedBox(
                width: 100,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.pages),
                    Text('700 pages'),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  await ref
                      .watch(savedBookNotifierProvider.notifier)
                      .saveOrRemove(widget.book);
                  getBookmarkStatus();
                },
                icon: iconBookmark,
              )
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              child: const Text('REVERSE THIS BOOK'),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
              width: double.infinity,
              child: Text(
                'Summary',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
          const SizedBox(
            height: 16,
          ),
          const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }

  void getBookmarkStatus() {
    ref.watch(bookmarkNotifierProvider.notifier).getBookmarkStatus(widget.book);
  }
}
