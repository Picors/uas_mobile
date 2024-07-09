import 'package:elysia/core/config/font_size.dart';
import 'package:elysia/core/config/routes.dart';
import 'package:elysia/features/stock/persentation/controller/stock.dart';
import 'package:elysia/features/stock/persentation/view/stock_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class StockFragment extends ConsumerWidget {
  const StockFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final stock = ref.watch(
      stockControllerProv(StockControllerParams()),
    );

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1), () {
            ref.invalidate(stockControllerProv);
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
                    "STOK",
                    style: TextStyle(
                      fontSize: size.height * h2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              stock.when(
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
                      final stockData = data[index];

                      return StockIndex(stockData: stockData);
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
          AppRoutes.goRouter.pushNamed(AppRoutes.stockForm);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
