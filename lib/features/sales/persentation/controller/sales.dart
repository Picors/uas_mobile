
import 'package:elysia/features/sales/data/sales.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SalesController extends StateNotifier<AsyncValue> {
  SalesController(
    this.salesRepository, {
    required this.params,
  }) : super(const AsyncValue.loading()) {
    sales();
  }

  final SalesRepository salesRepository;
  final SalesControllerParams params;

  Future sales() async {
    state = const AsyncValue.loading();
    try {
      final response = await salesRepository.addSales(
        buyer: params.buyer,
        phone: params.phone,
        date: params.date,
        status: params.status,
      );

      state = AsyncValue.data(response);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

class SalesControllerParams extends Equatable {
  const SalesControllerParams({
    required this.buyer,
    required this.phone,
    required this.date,
    required this.status,
  });

  final String buyer;
  final String phone;
  final String date;
  final String status;


  @override
  List<Object?> get props => [];
}

final addSalesControllerProv = AutoDisposeStateNotifierProviderFamily<
    SalesController, AsyncValue, SalesControllerParams>(
  (
    ref,
    params,
  ) {
    final addSalesRepository = ref.read(salesRepoProv);
    return SalesController(
      addSalesRepository,
      params: params,
    );
  },
);
