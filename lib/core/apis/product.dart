import 'package:elysia/core/helper/api.dart';

class ProductApi {
  Uri getProduct() {
    return ApiHelper.buildUri(
      endpoint: "/products",
    );
  }

  Uri getImgProduct(String id) {
    return ApiHelper.buildUri(
      endpoint: "/products/$id/image",
    );
  }

  Uri addProduct() {
    return ApiHelper.buildUri(
      endpoint: "/products",
    );
  }
}