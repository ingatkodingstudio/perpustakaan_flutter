import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 120,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                StaggeredGrid.count(
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                  axisDirection: AxisDirection.right,
                  children: [
                    'science',
                    'general knowledge',
                    'science',
                    'general knowledge' 'science',
                    'general knowledge' 'science',
                    'general knowledge' 'science',
                    'science',
                    'general knowledge'
                  ]
                      .map(
                        (e) => StaggeredGridTile.fit(
                          crossAxisCellCount: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(24)),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [const Icon(Icons.science), Text(e)],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
