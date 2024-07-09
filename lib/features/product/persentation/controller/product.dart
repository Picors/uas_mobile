

import 'package:elysia/features/product/data/product.dart';
import 'package:elysia/features/product/domain/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductController extends StateNotifier<AsyncValue<List<Product>>> {
  ProductController(
    this.productRepository, {
    required this.params,
  }) : super(const AsyncValue.loading()) {
    product();
  }

  final ProductRepository productRepository;
  final ProductControllerParams params;

  Future product() async {
    state = const AsyncValue.loading();
    try {
      final response = await productRepository.product();

      state = AsyncValue.data(response);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

class ProductControllerParams extends Equatable {
  @override
  List<Object?> get props => [];
}

final productControllerProv = AutoDisposeStateNotifierProviderFamily<
    ProductController, AsyncValue<List<Product>>, ProductControllerParams>(
  (
    ref,
    params,
  ) {
    final productRepository = ref.read(productRepoProv);
    return ProductController(
      productRepository,
      params: params,
    );
  },
);
