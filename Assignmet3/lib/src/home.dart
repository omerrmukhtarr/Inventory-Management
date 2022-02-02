import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:your_project_name/src/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:your_project_name/src/data_model.dart';

import 'package:your_project_name/src/detailrd_pop_up.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// Search Page
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  TextEditingController _searchController = TextEditingController();
  String? theSearch;
  String dropdownValue = 'date'; //bootcoamp name
  bool canSearch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Simple Inventory Management',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.yellow,

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
                      controller: _searchController,
                      decoration: InputDecoration(
                          label: Text('search'), hintText: 'Category'),
                      onChanged: (value) {
                        if (value.length < 1) {
                          setState(() {
                            canSearch = false;
                            debugPrint(canSearch.toString());
                          });
                        } else {
                          setState(() {
                            canSearch = true;
                            debugPrint(canSearch.toString());
                          });
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                      });
                    },
                    // canSearch == true
                    //     ? whatShouldIDO
                    //     : null, //if cansearch true return something, else return null
                    icon: Icon(Icons.clear),
                  )
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('product')
                    .where('category', isEqualTo: _searchController.value.text)
                    .snapshots()
                  ..map(
                    (docValue) => docValue.docs
                        .map(
                          (e) => Product.fromMap(
                            e.data(),
                          ),
                        )
                        .toList(),
                  ),
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
                      PopUp popUp = PopUp(
                        context: context,
                        cost: productList[index].cost.toString(),
                        price: productList[index].price.toString(),
                        release: productList[index].release.toString(),
                        desc: productList[index].desc.toString(),
                        exp: productList[index].exp.toString(),
                        url: productList[index].url,
                      );
                      return Slidable(
                        key: const ValueKey(0),
                        child: Card(
                          child: ListTile(
                            leading: Image.network(
                              productList[index].url ??
                                  "https://media.istockphoto.com/vectors/abstract-black-stripes-diagonal-background-vector-id1294603953?k=20&m=1294603953&s=612x612&w=0&h=KLAV73oMUFA2ucWMMTOdXT8Vn4LVUsh6NTiXRmlX5ZA=",
                              width: 100,
                              height: 100,
                              fit: BoxFit.scaleDown,
                            ),
                            onTap: () {
                              popUp.openDialog();
                            },
                            title: Text(productList[index].name.toString()),
                            subtitle:
                                Text(productList[index].category.toString()),
                            trailing: Material(
                              color: Colors.yellow,
                              child: SizedBox(
                                height: 100.0,
                                width: 100.0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      productList[index].quantity.toString()),
                                ),
                              ),
                            ),
                          ),
                        ),
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
                  backgroundColor: Colors.yellow,
                  child: const Icon(
                    Icons.add_box,
                    color: Colors.black,
                  ),
                  // child: null,
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
