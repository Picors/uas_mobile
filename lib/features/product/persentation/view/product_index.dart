import 'package:elysia/core/config/font_size.dart';
import 'package:elysia/features/product/domain/product.dart';
import 'package:elysia/features/product/persentation/controller/product_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

final productChart = StateProvider<List<Product>>((ref) => []);

class ProductIndex extends ConsumerWidget {
  const ProductIndex({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final imgData = ref.watch(
      productImgControllerProv(
        ProductImgParams(
          id: product.id,
        ),
      ),
    );

    final NumberFormat idCurrencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Center(
      child: Card(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.025,
                size.height * 0.01,
                size.width * 0.025,
                size.height * 0.01,
              ),
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: imgData.when(
                      data: (data) {
                        return data.img != null
                            ? Image.memory(
                                data.img!,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: Colors.grey,
                                child: const Center(
                                    child: Icon(
                                        Icons.image_not_supported_outlined)),
                              );
                      },
                      error: (error, stackTrace) {
                        return Container(
                          color: Colors.grey,
                          child: const Center(
                              child: Icon(Icons.image_not_supported_outlined)),
                        );
                      },
                      loading: () {
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  Gap(size.height * 0.01),
                  Center(
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontSize: size.height * h2,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Gap(size.height * 0.01),
                  Text(
                    "Jumlah : ${product.qty}",
                    style: TextStyle(fontSize: size.height * p1),
                  ),
                  Gap(size.height * 0.005),
                  Text(
                    "Harga : ${idCurrencyFormat.format(product.price)}",
                    style: TextStyle(fontSize: size.height * p1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, size.width * 0.025, size.width * 0.025, 0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.5),
                  ),
                  color: Colors.lightBlue,
                  onPressed: () {
                    ref.read(productChart.notifier).state = [
                      ...ref.watch(productChart),
                      product
                    ];
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
