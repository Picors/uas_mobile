import 'dart:typed_data';

class Stock {
  String id;
  String name;
  var qty;
  String attr;
  var weight;
  int createdAt;
  int updatedAt;
  String issuer;

  Stock({
    required this.id,
    required this.name,
    required this.qty,
    required this.attr,
    required this.weight,
    required this.createdAt,
    required this.updatedAt,
    required this.issuer,
  });

  factory Stock.fromMap(Map<String, dynamic> map) => Stock(
        id: map["id"],
        name: map["name"],
        qty: map["qty"],
        attr: map["attr"],
        weight: map["weight"],
        createdAt: map["createdAt"],
        updatedAt: map["updatedAt"],
        issuer: map["issuer"],
      );
}

class StockImg {
  Uint8List? img;

  StockImg({
    this.img,
  });

  factory StockImg.fromMap(Map<String, dynamic> map) => StockImg(
        img: map["image"],
      );
}
