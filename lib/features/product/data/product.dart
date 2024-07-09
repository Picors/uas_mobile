import 'package:elysia/core/apis/product.dart';
import 'package:elysia/core/helper/api.dart';
import 'package:elysia/features/product/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductRepository {
  ProductRepository(this.api);
  final ProductApi api;

  Future<List<Product>> product() async {
    return ApiHelper().getData(
      uri: api.getProduct(),
      builder: (data) {
        final product = data;

        return List.generate(
          product.length,
          (index) => Product.fromMap(
            product[index],
          ),
        );
      },
    );
  }

  Future<ProductImg> productImg(String id) async {
    return ApiHelper().getData(
      uri: api.getImgProduct(id),
      builder: (data) {
        return ProductImg.fromMap(data);
      },
    );
  }

  addProduct(
      {required String name,
      required int price,
      required int qty,
      required String attr,
      required double weight}) async {
    return await ApiHelper().postData(
      uri: api.addProduct(),
      builder: (data) async {},
      header: ApiHelper.header(),
      jsonBody: {
        "name": name,
        "price": price,
        "qty": qty,
        "attr": attr,
        "weight": weight,
      },
    );
  }
}

final productRepoProv = Provider(
  (ref) {
    final api = ProductApi();
    return ProductRepository(api);
  },
);
