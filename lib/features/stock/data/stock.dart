import 'package:elysia/core/apis/stock.dart';
import 'package:elysia/core/helper/api.dart';
import 'package:elysia/features/stock/domain/stock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StockRepository {
  StockRepository(this.api);
  final StockApi api;

  Future<List<Stock>> stock() async {
    return ApiHelper().getData(
      uri: api.getStock(),
      builder: (data) {
        final stock = data;

        return List.generate(
          stock.length,
          (index) => Stock.fromMap(
            stock[index],
          ),
        );
      },
    );
  }

  Future<StockImg> stockImg(String id) async {
    return ApiHelper().getData(
      uri: api.getStockImg(id),
      builder: (data) {
        return StockImg.fromMap(data);
      },
    );
  }

  addStock(
      {required String name,
      required int qty,
      required String attr,
      required int weight}) async {
    return await ApiHelper().postData(
      uri: api.addStock(),
      builder: (data) async {},
      header: ApiHelper.header(),
      jsonBody: {
        "name": name,
        "qty": qty,
        "attr": attr,
        "weight": weight,
      },
    );
  }
}

final stockRepoProv = Provider(
  (ref) {
    final api = StockApi();
    return StockRepository(api);
  },
);
