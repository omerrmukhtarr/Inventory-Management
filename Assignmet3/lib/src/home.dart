import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Home_Screen',
        color: Colors.grey[700],
        home: SearchPage());
  }
}

// Search Page
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Simple Inventory Management',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey,

        // The search area here
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              width: 1000,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          /* Clear the search field */
                        },
                      ),
                      hintText: 'Search',
                      border: InputBorder.none),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 300),
              alignment: Alignment.bottomCenter,
              child: new SizedBox(
                  child: FloatingActionButton(
                backgroundColor: Colors.red[900],
                child: null,
                shape: CircleBorder(
                    side: BorderSide(color: Colors.grey.shade800, width: 5)),
                onPressed: () {
                  print("Cliked");
                },
              )),
            ),
          ],
        ),
      ),
      //bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[600],
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.list,
              color: Colors.black,
            ),
            title: const Text(
              'List',
              style: TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.import_export, color: Colors.black),
              title: Text('Export', style: TextStyle(color: Colors.black))),
        ],
      ),
    );
  }
}
