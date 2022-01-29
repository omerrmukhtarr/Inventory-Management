import 'package:flutter/material.dart';
import 'add_product.dart';
import 'home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      initialRoute: '/',
      routes: {
        '/': (context) => const SearchPage(),
        '/add': (context) => const AddProduct(),
        '/card': (context) => const Card(),
      },
    );
  }
}
