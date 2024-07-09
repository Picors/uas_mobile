import 'package:elysia/features/product/data/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddProductController extends StateNotifier<AsyncValue> {
  AddProductController(
    this.productRepository, {
    required this.params,
  }) : super(const AsyncValue.loading()) {
    product();
  }

  final ProductRepository productRepository;
  final AddProductControllerParams params;

  Future product() async {
    state = const AsyncValue.loading();
    try {
      final response = await productRepository.addProduct(
        name: params.name,
        price: params.price,
        qty: params.qty,
        attr: params.attr,
        weight: params.weight,
      );

      state = AsyncValue.data(response);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

class AddProductControllerParams extends Equatable {
  const AddProductControllerParams({
    required this.name,
    required this.price,
    required this.qty,
    required this.attr,
    required this.weight,
  });

  final String name;
  final int price;
  final int qty;
  final String attr;
  final double weight;

  @override
  List<Object?> get props => [];
}

final addProductControllerProv = AutoDisposeStateNotifierProviderFamily<
    AddProductController, AsyncValue, AddProductControllerParams>(
  (
    ref,
    params,
  ) {
    final addProductRepository = ref.read(productRepoProv);
    return AddProductController(
      addProductRepository,
      params: params,
    );
  },
);
