import 'package:flutter/material.dart';
import 'data.dart';

class card extends StatefulWidget {
  const card({Key? key}) : super(key: key);

  @override
  _cardState createState() => _cardState();
}

class _cardState extends State<card> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
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
                          title: Text("Product Name:"),
                          subtitle: Text("Product Catigory"),
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
                          '200',
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
      ),
    );
  }
}
