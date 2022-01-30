import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:your_project_name/src/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:your_project_name/src/data_model.dart';

import 'package:your_project_name/src/detailrd_pop_up.dart';

// Search Page
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      // controller: _searchController,
                      decoration: InputDecoration(
                          label: Text('search'), hintText: 'name'),
                      onChanged: (value) {},
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  )
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('product')
                    .snapshots(),
                builder: (context, snapshot) {
                  try {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('error');
                    }
                  } on FirebaseAuthException catch (e) {
                    print(e);
                  }
                  List<DocumentSnapshot> _docs = snapshot.data!.docs;

                  List<Product> productList = _docs
                      .map((e) =>
                          Product.fromMap(e.data() as Map<String, dynamic>))
                      .toList();

                  return ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          height: 80,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(50),
                                  child: Expanded(
                                    child: Image.asset("assets/1.png"),
                                    flex: 1,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: ListTile(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text("Products"),
                                                  actions: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(Icons
                                                                .remove_red_eye_outlined),
                                                            Text('150')
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            width: 150,
                                                            height: 150,
                                                            child: Image.asset(
                                                              "assets/1.png",
                                                              fit: BoxFit
                                                                  .contain,
                                                              width: 150,
                                                              height: 150,
                                                            )),
                                                        Text("Cost: " +
                                                            productList[index]
                                                                .cost
                                                                .toString()),
                                                        Text("Desc: " +
                                                            productList[index]
                                                                .desc
                                                                .toString()),
                                                        Text("Release: " +
                                                            productList[index]
                                                                .release
                                                                .toString()),
                                                        Text("Exp: " +
                                                            productList[index]
                                                                .exp
                                                                .toString()),
                                                        Text("Price: " +
                                                            productList[index]
                                                                .price
                                                                .toString()),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          title: Text(productList[index]
                                              .name
                                              .toString()),
                                          subtitle: Text(productList[index]
                                              .category
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                flex: 3,
                              ),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.grey,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          productList[index].quantity ?? '',
                                          textAlign: TextAlign.center,
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
        //bottom Navigation Bar
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.list,
                    size: 30,
                  )),
              Container(
                child: SizedBox(
                    child: FloatingActionButton(
                  backgroundColor: Colors.red[900],
                  child: null,
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.grey.shade800, width: 5)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/add');
                  },
                )),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const SimpleDialog(
                          children: [
                            SimpleDialogOption(
                              child: Text('Export as PDF'),
                            ),
                            SimpleDialogOption(
                              child: Text('Export as CSV'),
                            ),
                            SimpleDialogOption(
                              child: Text('Export as JSON'),
                            ),
                            SimpleDialogOption(
                              child: Text('Export as TEXT'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.import_export,
                    size: 30,
                  ))
            ],
          ),
        ));
  }
}
