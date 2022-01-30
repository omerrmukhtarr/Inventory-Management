import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  DateTime _releaseDate = DateTime.now();
  DateTime _expireDate = DateTime.now();
  // final ImagePicker _picker = ImagePicker();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        _releaseDate = value!;
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
        _expireDate = value!;
      });
    });
  }

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedProfileImg;
  // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String? _theDlUrl;
  bool _isLoading = false;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final _formGlobalKey = GlobalKey<FormState>();

  String? scanResult;
  @override
  Widget build(BuildContext context) {
    final TextEditingController _categoryController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _infoController = TextEditingController();
    final TextEditingController _quantityController = TextEditingController();
    final TextEditingController _costController = TextEditingController();
    final TextEditingController _priceController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
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
                    Padding(
                      padding:
                          EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
                      child: Form(
                        child: Column(
                          children: [
                            Card(
                              child: TextField(
                                controller: _categoryController,
                                decoration: InputDecoration(
                                  labelText: 'Category',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200, width: 2),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Product Name',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200, width: 2),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: TextField(
                                controller: _infoController,
                                decoration: InputDecoration(
                                  labelText: 'Product Info',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200, width: 2),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: TextField(
                                controller: _quantityController,
                                onSubmitted: (value) => TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'Quantity',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200, width: 2),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: TextField(
                                controller: _costController,
                                decoration: InputDecoration(
                                  labelText: 'Cost',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200, width: 2),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: TextField(
                                controller: _priceController,
                                decoration: InputDecoration(
                                  labelText: 'Price',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200, width: 2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Center(
                                    child: Text(
                                      'Release:  ' +
                                          _releaseDate.year.toString() +
                                          '/' +
                                          _releaseDate.month.toString() +
                                          '/' +
                                          _releaseDate.day.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Center(
                                    child: Text(
                                      'Expire:  ' +
                                          _expireDate.year.toString() +
                                          '/' +
                                          _expireDate.month.toString() +
                                          '/' +
                                          _expireDate.day.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
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
                                          icon: Icon(
                                            Icons.image_rounded,
                                            size: 60,
                                          )),
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
                                  onPressed: () async {
                                    //upload the selected image
                                    // await _firebaseStorage
                                    //     .ref()
                                    //     .putFile(_theImageFile)
                                    //     .then((p) async {
                                    //   _theDlUrl = await p.ref.getDownloadURL();
                                    //   debugPrint("dl =======> " + _theDlUrl!);
                                    // });
                                    await FirebaseFirestore.instance
                                        .collection('product')
                                        .add({
                                      'barcode': '',
                                      'category':
                                          _categoryController.value.text,
                                      'name': _nameController.value.text,
                                      'desc': _infoController.value.text,
                                      'quantity':
                                          _quantityController.value.text,
                                      'cost': _costController.value.text,
                                      'price': _priceController.value.text,
                                      'release': 'Release:  ' +
                                          _releaseDate.year.toString() +
                                          '/' +
                                          _releaseDate.month.toString() +
                                          '/' +
                                          _releaseDate.day.toString(),
                                      'expire': 'Expire:  ' +
                                          _expireDate.year.toString() +
                                          '/' +
                                          _expireDate.month.toString() +
                                          '/' +
                                          _expireDate.day.toString(),
                                      'imgUrl': uploadTheSelectedFile(),
                                    });
                                    _categoryController.clear();
                                    _nameController.clear();
                                    _priceController.clear();
                                    _infoController.clear();
                                    _costController.clear();
                                    _quantityController.clear();
                                  },
                                  child: Text('Add Product')),
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

  Future<String?> uploadTheSelectedFile() async {
    //selected image as file
    File _theImageFile = File(_selectedProfileImg!.path);

    //upload the selected image
    await _firebaseStorage.ref().putFile(_theImageFile).then((p) async {
      _theDlUrl = await p.ref.getDownloadURL();
    });
    return _theDlUrl;
    //todo remove this if for production
    //recieve the downloadURL for the image
  }
}
