import 'package:elysia/features/stock/data/stock.dart';
import 'package:elysia/features/stock/domain/stock.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StockImgController extends StateNotifier<AsyncValue<StockImg>> {
  StockImgController(
    this.stockRepository, {
    required this.params,
  }) : super(const AsyncValue.loading()) {
    stock();
  }

  final StockRepository stockRepository;
  final StockImgParams params;

  Future stock() async {
    state = const AsyncValue.loading();
    try {
      final response = await stockRepository.stockImg(params.id);

      state = AsyncValue.data(response);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

class StockImgParams extends Equatable {
  const StockImgParams({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [];
}

final stockImgControllerProv = AutoDisposeStateNotifierProviderFamily<
    StockImgController, AsyncValue<StockImg>, StockImgParams>(
  (
    ref,
    params,
  ) {
    final stockImgRepository = ref.read(stockRepoProv);
    return StockImgController(
      stockImgRepository,
      params: params,
    );
  },
);
