import 'package:elysia/core/config/routes.dart';
import 'package:elysia/features/product/persentation/controller/add_product.dart';
import 'package:elysia/features/product/persentation/controller/product.dart';
import 'package:elysia/features/product/persentation/view/product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductApplication {
  product({
    required BuildContext context,
    required Size size,
    required String name,
    required int price,
    required int qty,
    required String attr,
    required double weight,
  }) {
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final response = ref.watch(
              addProductControllerProv(
                AddProductControllerParams(
                  name: name,
                  price: price,
                  qty: qty,
                  attr: attr,
                  weight: weight,
                ),
              ),
            );
            return response.when(
              data: (data) {
                ref.invalidate(productControllerProv);
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
                    ref.read(isProductErrorProvider.notifier).state = true;
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
