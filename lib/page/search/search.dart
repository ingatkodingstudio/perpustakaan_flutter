import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final String keyword;
  final TextEditingController _controller = TextEditingController();

  Search(this.keyword, {super.key});

  @override
  Widget build(BuildContext context) {
    _controller.text = keyword;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onSubmitted: (value) {}),
      ),
      body: Center(
        child: Text("Search $keyword"),
      ),
    );
  }
}
