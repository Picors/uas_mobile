import 'package:elysia/core/config/routes.dart';
import 'package:elysia/features/product/persentation/view/product_index.dart';

import 'package:elysia/features/sales/persentation/controller/sales.dart';
import 'package:elysia/features/sales/persentation/view/sales_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SalesApplication {
  sales({
    required BuildContext context,
    required Size size,
    required String buyer,
    required String phone,
    required String date,
    required String status,
  }) {
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final response = ref.watch(
              addSalesControllerProv(
                SalesControllerParams(
                  buyer: buyer,
                  phone: phone,
                  date: date,
                  status: status,
                ),
              ),
            );
            return response.when(
              data: (data) {
                Future.delayed(
                  const Duration(milliseconds: 300),
                  () {
                    ref.read(isLoadingProvider.notifier).state = false;
                    Future.delayed(
                      const Duration(milliseconds: 300),
                      () {
                        ref.read(productChart.notifier).state = [];
                        AppRoutes.goRouter.pop();
                        Future.delayed(
                          const Duration(milliseconds: 300),
                          () {
                            AppRoutes().clearAndNavigate(AppRoutes.home);
                          },
                        );
                      },
                    );
                  },
                );
                return const SizedBox();
              },
              error: (error, stackTrace) {
                debugPrint(error.toString());

                Future.delayed(
                  const Duration(milliseconds: 300),
                  () {
                    ref.read(isPayErrorProvider.notifier).state = true;
                    ref.read(isLoadingProvider.notifier).state = false;

                    AppRoutes.goRouter.pop();
                  },
                );

                return const SizedBox();
              },
              loading: () {
                Future.delayed(const Duration(milliseconds: 100), () {
                  ref.read(isLoadingProvider.notifier).state = true;
                });

                return const SizedBox();
              },
            );
          },
        );
      },
    );
  }
}
