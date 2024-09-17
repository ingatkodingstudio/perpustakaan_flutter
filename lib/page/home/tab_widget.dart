import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  ListView.separated(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 12,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: index == 0 ? 16 : 0,
                            right: index == 4 ? 16 : 0),
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
                              const Text(
                                'Book Title Here',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Author',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
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
                  ),
                  Container(),
                  Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
