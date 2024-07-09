import 'package:elysia/core/apis/sales.dart';
import 'package:elysia/core/helper/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SalesRepository {
  SalesRepository(this.api);
  final SalesApi api;

  addSales(
      {required String buyer,
      required String phone,
      required String date,
      required String status,}) async {
    return await ApiHelper().postData(
      uri: api.sales(),
      builder: (data) async {},
      header: ApiHelper.header(),
      jsonBody: {
        "buyer": buyer,
        "phone": phone,
        "date": date,
        "status": status,
      },
    );
  }
}

final salesRepoProv = Provider(
  (ref) {
    final api = SalesApi();
    return SalesRepository(api);
  },
);
