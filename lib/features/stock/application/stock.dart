import 'package:elysia/core/config/routes.dart';
import 'package:elysia/features/stock/persentation/controller/add_stock.dart';
import 'package:elysia/features/stock/persentation/controller/stock.dart';
import 'package:elysia/features/stock/persentation/view/stock_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StockApplication {
  stock({
    required BuildContext context,
    required Size size,
    required String name,
    required int qty,
    required String attr,
    required int weight,
  }) {
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final response = ref.watch(
              addStockControllerProv(
                AddStockControllerParams(
                  name: name,
                  qty: qty,
                  attr: attr,
                  weight: weight,
                ),
              ),
            );
            return response.when(
              data: (data) {
                ref.invalidate(stockControllerProv);
                Future.delayed(
                  const Duration(milliseconds: 300),
                  () {
                    ref.read(isLoadingProvider.notifier).state = false;
                    Future.delayed(
                      const Duration(milliseconds: 300),
                      () {
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
                    ref.read(isStockErrorProvider.notifier).state = true;
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
