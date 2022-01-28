class Product {
  String? name;
  String? desc; // the uid from firebase auth service
  int? quantity;
  double? cost;
  double? price;

  DateTime? release;
  DateTime? exp;

  Product({
    this.cost,
    this.name,
    this.desc,
    this.exp,
    this.price,
    this.quantity,
    this.release,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        name: json["name"],
        cost: json["cost"],
        desc: json["desc"],
        exp: json["exp"],
        price: json["price"],
        quantity: json["quantity"],
        release: json["release"],
      );

  Map<String, dynamic> toMap() => {

    "name": name,
    "cost":cost,
    "exp":exp,
    "release":release,
    "quantity":quantity,
    "price":price,
    "desc":desc,
  };
}
