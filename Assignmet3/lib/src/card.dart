import 'dart:convert';

import 'package:flutter/material.dart';

class CardList {
  String? name;
  String? category;
  String? quantity;
  CardList({this.name, this.category, this.quantity});
  Card uiCard() {
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
                        title: Text("Product Name:" + "$name"),
                        subtitle: Text("Product Catigory" + "$category"),
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
                        "$quantity",
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
  }
}
