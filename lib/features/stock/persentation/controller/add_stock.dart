import 'package:elysia/features/stock/data/stock.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddStockController extends StateNotifier<AsyncValue> {
  AddStockController(
    this.stockRepository, {
    required this.params,
  }) : super(const AsyncValue.loading()) {
    stock();
  }

  final StockRepository stockRepository;
  final AddStockControllerParams params;

  Future stock() async {
    state = const AsyncValue.loading();
    try {
      final response = await stockRepository.addStock(
        name: params.name,
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

class AddStockControllerParams extends Equatable {
  const AddStockControllerParams({
    required this.name,
    required this.qty,
    required this.attr,
    required this.weight,
  });

  final String name;
  final int qty;
  final String attr;
  final int weight;

  @override
  List<Object?> get props => [];
}

final addStockControllerProv = AutoDisposeStateNotifierProviderFamily<
    AddStockController, AsyncValue, AddStockControllerParams>(
  (
    ref,
    params,
  ) {
    final addStockRepository = ref.read(stockRepoProv);
    return AddStockController(
      addStockRepository,
      params: params,
    );
  },
);
