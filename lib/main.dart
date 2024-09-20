import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perpustakaan_app/page/home/home.dart';
import 'package:perpustakaan_app/page/search/search.dart';
import 'package:perpustakaan_app/page/notification/notification.dart'
    as notification_page;

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class Route {
  static const String home = '/';
  static const String notification = '/notification';
  static const String search = '/search';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      initialRoute: Route.home,
      routes: {
        Route.home: (context) => const Home(),
        Route.notification: (context) => const notification_page.Notification()
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Route.search:
            final args = settings.arguments as String;

            return MaterialPageRoute(
              builder: (context) => Search(args),
            );
          default:
            return null;
        }
      },
    );
  }
}
