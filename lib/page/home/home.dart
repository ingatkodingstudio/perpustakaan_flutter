import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perpustakaan_app/page/home/categories_widget.dart';
import 'package:perpustakaan_app/page/home/search_widget.dart';
import 'package:perpustakaan_app/page/home/tab_widget.dart';
import 'package:perpustakaan_app/page/home/top_authors_widget.dart';
import 'package:perpustakaan_app/main.dart' as main;
import 'package:perpustakaan_app/page/saved/saved.dart';
import 'package:perpustakaan_app/provider/book_notifier.dart';
import 'package:perpustakaan_app/provider/bottom_navigation_notifier.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(bottomNavigationNotifierProvider);

    Widget content;

    switch (currentPage) {
      case 2:
        content = const Center(
          child: Text('Borrowed'),
        );
        break;
      case 3:
        content = const Saved();
        break;
      default:
        content = _content(ref);
    }

    return Scaffold(
      appBar: _appBar(context),
      body: content,
      bottomNavigationBar: _bottomNavigation(context, ref),
    );
  }

  Widget _content(WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () {
        return fetchBooks(ref);
      },
      child: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            SearchWidget(),
            SizedBox(
              height: 24,
            ),
            TabWidget(),
            SizedBox(
              height: 16,
            ),
            CategoriesWidget(),
            SizedBox(
              height: 16,
            ),
            TopAuthorsWidget(),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(main.Route.notification);
          },
          icon: const Icon(Icons.notifications),
        ),
        IconButton(
          onPressed: () {},
          icon: const CircleAvatar(
            backgroundColor: Colors.amber,
          ),
        )
      ],
    );
  }

  BottomNavigationBar _bottomNavigation(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(bottomNavigationNotifierProvider);

    return BottomNavigationBar(
      selectedItemColor: Colors.amber[800], // Color for selected item
      unselectedItemColor: Colors.black,
      unselectedLabelStyle: const TextStyle(color: Colors.black),
      selectedLabelStyle: TextStyle(color: Colors.amber[800]),
      showUnselectedLabels: true,
      currentIndex: currentPage,
      onTap: (value) {
        if (value == 1) {
          Navigator.pushNamed(context, main.Route.search, arguments: '');
        } else {
          ref.read(bottomNavigationNotifierProvider.notifier).changePage(value);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timer),
          label: 'Borrowed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Saved',
        )
      ],
    );
  }

  Future<void> fetchBooks(WidgetRef ref) {
    return ref.read(bookNotifierProvider.notifier).fetchData();
  }
}
