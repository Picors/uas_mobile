import 'package:elysia/core/config/font_size.dart';
import 'package:elysia/core/config/routes.dart';
import 'package:elysia/features/product/persentation/controller/product_img.dart';
import 'package:elysia/features/product/persentation/view/product_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CartFragment extends ConsumerWidget {
  const CartFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final listChart = ref.watch(productChart);
    final NumberFormat idCurrencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Scaffold(
      body: listChart.isEmpty
          ? const Center(child: Text("Keranjang Kosong"))
          : SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.025,
                size.height * 0.03,
                size.width * 0.025,
                0,
              ),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final product = listChart[index];
                  final imgData = ref.watch(
                    productImgControllerProv(
                      ProductImgParams(
                        id: product.id,
                      ),
                    ),
                  );
                  return Dismissible(
                    key: Key(product.id),
                    // Provide a function that tells the app
                    // what to do after an item has been swiped away.
                    onDismissed: (direction) {
                      // Remove the item from the data source.
                      ref.read(productChart).removeAt(index);

                      // Then show a snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product.name} dismissed')));
                    },
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: SizedBox(
                          height: size.height * 0.08,
                          width: size.height * 0.08,
                          child: imgData.when(
                            data: (data) {
                              return data.img != null
                                  ? Image.memory(
                                      data.img!,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.image_not_supported_outlined,
                                        ),
                                      ),
                                    );
                            },
                            error: (error, stackTrace) {
                              return Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                                child: const Center(
                                  child:
                                      Icon(Icons.image_not_supported_outlined),
                                ),
                              );
                            },
                            loading: () {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ),
                        title: Text(
                          listChart[index].name,
                          style: TextStyle(
                              fontSize: size.height * p1,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          "Harga : ${idCurrencyFormat.format(listChart[index].price)} ",
                          style: TextStyle(fontSize: size.height * p1),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: listChart.length,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.025,
          0,
          size.width * 0.025,
          0,
        ),
        child: SizedBox(
          width: size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              AppRoutes.goRouter.pushNamed(AppRoutes.salesForm);
            },
            child: Text(
              "Checkout",
              style: TextStyle(
                fontSize: size.height * h3,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
