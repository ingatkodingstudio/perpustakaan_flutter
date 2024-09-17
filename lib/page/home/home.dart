import 'package:flutter/material.dart';
import 'package:perpustakaan_app/page/home/categories_widget.dart';
import 'package:perpustakaan_app/page/home/search_widget.dart';
import 'package:perpustakaan_app/page/home/tab_widget.dart';
import 'package:perpustakaan_app/page/home/top_authors_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: const SingleChildScrollView(
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
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
      ),
      actions: [
        IconButton(
          onPressed: () {},
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

  BottomNavigationBar _bottomNavigation() {
    return BottomNavigationBar(
      selectedItemColor: Colors.amber[800], // Color for selected item
      unselectedItemColor: Colors.black,
      unselectedLabelStyle: const TextStyle(color: Colors.black),
      selectedLabelStyle: TextStyle(color: Colors.amber[800]),
      showUnselectedLabels: true,
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
}
