import 'package:flutter/material.dart';
import 'package:your_project_name/src/detailrd_pop_up.dart';

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
    Future openDialog() => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Products"),
            actions: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye_outlined),
                      Text('150')
                    ],
                  ),
                  SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.asset(
                        "assets/1.png",
                        fit: BoxFit.contain,
                        width: 150,
                        height: 150,
                      )),
                  Text("Cost: " + ""),
                  Text("Name: " + ""),
                  Text("Desc: " + ""),
                  Text("Exp: " + ""),
                  Text("Price: " + ""),
                  Text("Quantity: " + ""),
                  Text("Release: " + ""),
                ],
              ),
            ],
          ),
        );
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
            ElevatedButton(
              onPressed: () {
                // return showDialog(context: context, builder: builder)
                openDialog();
              },
              child: Material(
                color: Colors.lightBlueAccent,
                child: SizedBox(width: 150, height: 70),
              ),
            ),
            FloatingActionButton(
              backgroundColor: Colors.red[900],
              child: null,
              shape: CircleBorder(
                  side: BorderSide(color: Colors.grey.shade800, width: 5)),
              onPressed: () {},
            ),
          ],
        ),
      ),
      //bottom Navigation Bar

      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
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
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
