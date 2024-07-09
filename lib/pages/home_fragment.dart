import 'package:elysia/core/config/font_size.dart';
import 'package:elysia/features/product/persentation/controller/product.dart';
import 'package:elysia/features/stock/persentation/controller/stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
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
                "BERANDA",
                style: TextStyle(
                  fontSize: size.height * h2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Gap(size.height * 0.025),

          /// Stok
          Padding(
            padding: EdgeInsets.fromLTRB(
              size.width * 0.03,
              0,
              size.width * 0.03,
              0,
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.02,
                size.height * 0.01,
                size.width * 0.06,
                size.height * 0.01,
              ),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warehouse_outlined,
                        size: size.height * 0.05,
                        color: Colors.white,
                      ),
                      Gap(size.width * 0.03),
                      Text(
                        "Stok",
                        style: TextStyle(
                          fontSize: size.height * 0.025,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final stock = ref.watch(
                        stockControllerProv(StockControllerParams()),
                      );
                      return stock.when(data: (data) {
                        return Text(
                          data.length.toString(),
                          style: TextStyle(
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }, error: (error, stackTrace) {
                        return const Text("0");
                      }, loading: () {
                        return const CircularProgressIndicator();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Gap(size.height * 0.025),

          /// Produk
          Padding(
            padding: EdgeInsets.fromLTRB(
              size.width * 0.03,
              0,
              size.width * 0.03,
              0,
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.02,
                size.height * 0.01,
                size.width * 0.06,
                size.height * 0.01,
              ),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.grid_view_outlined,
                        size: size.height * 0.05,
                        color: Colors.white,
                      ),
                      Gap(size.width * 0.03),
                      Text(
                        "Produk",
                        style: TextStyle(
                          fontSize: size.height * 0.025,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final stock = ref.watch(
                        productControllerProv(ProductControllerParams()),
                      );
                      return stock.when(data: (data) {
                        return Text(
                          data.length.toString(),
                          style: TextStyle(
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }, error: (error, stackTrace) {
                        return const Text("0");
                      }, loading: () {
                        return const CircularProgressIndicator();
                      });
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
