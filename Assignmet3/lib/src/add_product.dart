import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  DateTime _dateTime = DateTime.now();
  DateTime _dateTime2 = DateTime.now();
  // final ImagePicker _picker = ImagePicker();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  void _showDatePicker2() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        _dateTime2 = value!;
      });
    });
  }

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedProfileImg;
  // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String? _theDlUrl;
  bool _isLoading = false;

  final _formGlobalKey = GlobalKey<FormState>();

  String? scanResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        // ),
        body: Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
            child: Form(
                child: Column(children: [
              Expanded(
                child: ListView(
                  children: [
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Barcode Scanner",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                                onPressed: scanBarcode,
                                icon: Icon(
                                  Icons.qr_code_2,
                                  size: 50,
                                ))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text('Category'),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text('product name'),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text('Product Desc'),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text('Product_Quantity'),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text('Product_Cost'),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text('Product_Price'),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Flexible(
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(_dateTime.toString()),
                                ),
                              ),
                            ),
                            Flexible(
                              child: IconButton(
                                onPressed: _showDatePicker,
                                icon: Icon(Icons.date_range),
                                iconSize: 60,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Flexible(
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(_dateTime2.toString()),
                                ),
                              ),
                            ),
                            Flexible(
                              child: IconButton(
                                onPressed: _showDatePicker2,
                                icon: Icon(Icons.date_range),
                                iconSize: 60,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          // padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              _selectedProfileImg == null
                                  ? Container(
                                      child: IconButton(
                                          onPressed: () async {
                                            // add image picker package
                                            _selectedProfileImg =
                                                await _imagePicker.pickImage(
                                                    source:
                                                        ImageSource.gallery);

                                            // debugPrint("===========>>>" + _selectedProfileImg!.path);
                                            setState(() {});
                                            // pick an image from the gallery
                                          },
                                          icon: Icon(Icons.image)),
                                      height: 120,
                                      width: 120,
                                      decoration:
                                          BoxDecoration(color: Colors.grey),
                                    )
                                  : Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: _selectedProfileImg == null
                                            ? Colors.black
                                            : null,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: FileImage(
                                            File(_selectedProfileImg!.path),
                                          ),
                                        ),
                                      ),
                                    ),
                              ElevatedButton(
                                  onPressed: () {}, child: Text('Add Product')),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]))));
  }

  Future scanBarcode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      scanResult = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() => this.scanResult = scanResult);
  }
}
