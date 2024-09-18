import 'package:flutter/material.dart';
import 'package:perpustakaan_app/main.dart' as main;

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onSubmitted: (value) =>
            Navigator.pushNamed(context, main.Route.search, arguments: value),
      ),
    );
  }
}
