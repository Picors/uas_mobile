import 'package:elysia/core/config/font_size.dart';
import 'package:elysia/core/config/routes.dart';
import 'package:elysia/features/product/persentation/controller/product.dart';
import 'package:elysia/features/product/persentation/view/product_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ProductFragment extends ConsumerWidget {
  const ProductFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final product = ref.watch(
      productControllerProv(ProductControllerParams()),
    );

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1), () {
            ref.invalidate(productControllerProv);
          });
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Gap(size.height * 0.025),
              Container(
                padding: EdgeInsets.fromLTRB(
                  0,
                  size.height * 0.005,
                  0,
                  size.height * 0.005,
                ),
                color: Colors.green,
                child: Center(
                  child: Text(
                    "PRODUK",
                    style: TextStyle(
                      fontSize: size.height * h2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              product.when(
                data: (data) {
                  return GridView.builder(
                    padding: EdgeInsets.only(top: size.height * 0.025),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final productData = data[index];

                      return ProductIndex(product: productData);
                    },
                  );
                },
                error: (error, stackTrace) {
                  return Center(child: Text(error.toString()));
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          AppRoutes.goRouter.pushNamed(AppRoutes.productForm);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
