class Product {
  String? barcode;
  String? category;
  String? name;
  String? desc; // the uid from firebase auth service
  String? quantity;
  String? cost;
  String? price;
  String? url;
  String? release;
  String? exp;

  Product(
      {this.barcode,
      this.url,
      this.category,
      this.name,
      this.desc,
      this.quantity,
      this.cost,
      this.price,
      this.release,
      this.exp});

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        barcode: json['barcode'],
        category: json['category'],
        name: json["name"],
        desc: json["desc"],
        quantity: json["quantity"],
        cost: json["cost"],
        price: json["price"],
        release: json["release"],
        exp: json["expire"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "barcode": barcode,
        "category": category,
        "name": name,
        "desc": desc,
        "quantity": quantity,
        "cost": cost,
        "price": price,
        "release": release,
        "expire": exp,
        "url": url,
      };
}
