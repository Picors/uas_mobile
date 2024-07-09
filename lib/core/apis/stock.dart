import 'package:elysia/core/helper/api.dart';

class StockApi {
  Uri getStock() {
    return ApiHelper.buildUri(
      endpoint: "/stocks",
    );
  }

  Uri getStockImg(String id) {
    return ApiHelper.buildUri(
      endpoint: "/stocks/$id/image",
    );
  }

  Uri addStock() {
    return ApiHelper.buildUri(
      endpoint: "/stocks",
    );
  }
}
