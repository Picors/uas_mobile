

import 'dart:typed_data';

class Product {
  String id;
  String name;
  int price;
  String attr;
  int qty;
  var weight;
  int createdAt;
  int updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.attr,
    required this.qty,
    required this.weight,
    required this.createdAt,
    required this.updatedAt,
  });


  factory Product.fromMap(Map<String, dynamic> map) => Product(
        id: map["id"],
        name: map["name"],
        price: map["price"],
        attr: map["attr"],
        qty: map["qty"],
        weight: map["weight"],
        createdAt: map["createdAt"],
        updatedAt: map["updatedAt"],
      );
}

class ProductImg {
  Uint8List? img;

  ProductImg({
    this.img,
  });

  factory ProductImg.fromMap(Map<String, dynamic> map) => ProductImg(
        img: map["image"],
      );
}
