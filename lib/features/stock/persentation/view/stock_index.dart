import 'package:elysia/core/config/font_size.dart';
import 'package:elysia/features/stock/domain/stock.dart';
import 'package:elysia/features/stock/persentation/controller/stock_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class StockIndex extends ConsumerWidget {
  const StockIndex({
    super.key,
    required this.stockData,
  });
  final Stock stockData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final imgData = ref.watch(
      stockImgControllerProv(
        StockImgParams(
          id: stockData.id,
        ),
      ),
    );

    return Center(
      child: Card(
        color: Colors.white,
        child: Container(
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
              // Image.network("src"),
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
                                child:
                                    Icon(Icons.image_not_supported_outlined)),
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
                  stockData.name,
                  style: TextStyle(
                    fontSize: size.height * h2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gap(size.height * 0.01),
              Text(
                "Jumlah : ${stockData.qty}",
                style: TextStyle(fontSize: size.height * p1),
              ),
              Gap(size.height * 0.005),
              Text(
                "Berat : ${(stockData.weight)} ${stockData.attr}",
                style: TextStyle(fontSize: size.height * p1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
