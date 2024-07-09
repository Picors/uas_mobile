import 'package:elysia/features/stock/data/stock.dart';
import 'package:elysia/features/stock/domain/stock.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StockController extends StateNotifier<AsyncValue<List<Stock>>> {
  StockController(
    this.stockRepository, {
    required this.params,
  }) : super(const AsyncValue.loading()) {
    stock();
  }

  final StockRepository stockRepository;
  final StockControllerParams params;

  Future stock() async {
    state = const AsyncValue.loading();
    try {
      final response = await stockRepository.stock();

      state = AsyncValue.data(response);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

class StockControllerParams extends Equatable {
  @override
  List<Object?> get props => [];
}

final stockControllerProv = AutoDisposeStateNotifierProviderFamily<
    StockController, AsyncValue<List<Stock>>, StockControllerParams>(
  (
    ref,
    params,
  ) {
    final stockRepository = ref.read(stockRepoProv);
    return StockController(
      stockRepository,
      params: params,
    );
  },
);
