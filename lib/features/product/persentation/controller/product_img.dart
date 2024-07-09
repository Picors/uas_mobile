import 'package:elysia/features/product/data/product.dart';
import 'package:elysia/features/product/domain/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductImgController extends StateNotifier<AsyncValue<ProductImg>> {
  ProductImgController(
    this.productRepository, {
    required this.params,
  }) : super(const AsyncValue.loading()) {
    product();
  }

  final ProductRepository productRepository;
  final ProductImgParams params;

  Future product() async {
    state = const AsyncValue.loading();
    try {
      final response = await productRepository.productImg(params.id);

      state = AsyncValue.data(response);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

class ProductImgParams extends Equatable {
  const ProductImgParams({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [];
}

final productImgControllerProv = AutoDisposeStateNotifierProviderFamily<
    ProductImgController, AsyncValue<ProductImg>, ProductImgParams>(
  (
    ref,
    params,
  ) {
    final productImgRepository = ref.read(productRepoProv);
    return ProductImgController(
      productImgRepository,
      params: params,
    );
  },
);
