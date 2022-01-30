import 'package:flutter/material.dart';

class PopUp {
  PopUp(
      {required this.context,
      required this.cost,
      required this.price,
      required this.release,
      required this.exp,
      required this.url,
      required this.desc});

  late final BuildContext context;
  late final String cost;
  final String? url;

  late final String desc;
  late final String exp;
  late final String price;

  late final String release;

  Future openDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Products"),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [Icon(Icons.remove_red_eye_outlined), Text('150')],
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: Image.network(
                  url ??
                      "https://media.istockphoto.com/vectors/abstract-black-stripes-diagonal-background-vector-id1294603953?k=20&m=1294603953&s=612x612&w=0&h=KLAV73oMUFA2ucWMMTOdXT8Vn4LVUsh6NTiXRmlX5ZA=",
                  width: 100,
                  height: 100,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text("Cost: " + cost),
              Text("Desc: " + desc),
              Text("Exp: " + exp),
              Text("Price: " + price),
              Text("Release: " + release),
            ],
          ),
        ],
      ),
    );
  }
}
