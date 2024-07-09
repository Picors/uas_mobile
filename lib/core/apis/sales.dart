import 'package:elysia/core/helper/api.dart';

class SalesApi {
Uri sales() {
    return ApiHelper.buildUri(
      endpoint: "/sales",
    );
  }
}