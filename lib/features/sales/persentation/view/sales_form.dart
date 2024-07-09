import 'package:elysia/core/config/font_size.dart';
import 'package:elysia/features/product/domain/product.dart';
import 'package:elysia/features/product/persentation/view/product_form.dart';
import 'package:elysia/features/product/persentation/view/product_index.dart';
import 'package:elysia/features/sales/application/sales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

final buyerControllerProv = StateProvider.autoDispose<TextEditingController>(
    (ref) => TextEditingController());
final phoneControllerProv = StateProvider.autoDispose<TextEditingController>(
    (ref) => TextEditingController());

final statusList = ["Lunas", "Belum Lunas"];

final dropdownValueController = StateProvider.autoDispose<String>(
  (ref) => statusList.first,
);

final isLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);

final isPayErrorProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

class SalesForm extends ConsumerWidget {
  const SalesForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    String dropdownValue = ref.watch(dropdownValueController);
    final buyerController = ref.watch(buyerControllerProv);
    final phoneController = ref.watch(phoneControllerProv);
    final listChart = ref.watch(productChart);

    final isLoading = ref.watch(isLoadingProvider);
    final isPayError = ref.watch(isPayErrorProvider);

    final formKey = GlobalKey<FormState>();

    int calculateTotalPrice(List<Product> products) {
      int totalPrice = 0;
      for (Product product in products) {
        totalPrice += product.price;
      }
      return totalPrice;
    }

    final NumberFormat idCurrencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.03,
          0,
          size.width * 0.03,
          0,
        ),
        child: Column(
          children: [
            TextFormField(
              controller: buyerController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: "Nama Pembeli",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value == "") {
                  return "Nama Pembeli harus diisi";
                }

                return null;
              },
            ),
            Gap(size.height * 0.025),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nomor HP",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value == "") {
                  return "Nomor HP harus diisi";
                }

                return null;
              },
            ),
            Gap(size.height * 0.025),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.3,
                  child: Text(
                    "Jumlah Yang harus dibayarkan",
                    maxLines: 2,
                    style: TextStyle(fontSize: size.height * p1),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: idCurrencyFormat.format(
                      calculateTotalPrice(listChart),
                    ),
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Harga harus diisi";
                      }

                      return null;
                    },
                  ),
                ),
              ],
            ),
            Gap(size.height * 0.025),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.3,
                  child: Text(
                    "Status Pembayaran",
                    maxLines: 2,
                    style: TextStyle(fontSize: size.height * p1),
                  ),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    onChanged: (String? value) {
                      ref.read(dropdownValueController.notifier).state = value!;
                    },
                    items: statusList.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
            Gap(size.height * 0.05),
            ErrorCondition(isProductError: isPayError, size: size),
            SizedBox(
              width: size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    SalesApplication().sales(
                      context: context,
                      size: size,
                      buyer: buyerController.text,
                      phone: phoneController.text,
                      date: DateTime.now().toString(),
                      status: dropdownValue,
                    );
                  }
                },
                child: isLoading
                    ? Center(
                        child: SizedBox(
                          height: size.height * 0.03,
                          width: size.height * 0.03,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        "Bayar",
                        style: TextStyle(
                          fontSize: size.height * h3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorCondition extends ConsumerWidget {
  const ErrorCondition({
    super.key,
    required this.isProductError,
    required this.size,
  });

  final bool isProductError;
  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: isProductError,
      child: Column(
        children: [
          Container(
            width: size.width,
            padding: EdgeInsets.fromLTRB(
              size.width * 0.06,
              size.height * 0.02,
              size.width * 0.06,
              size.height * 0.02,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.red.withOpacity(0.1),
            ),
            child: Text(
              "Gagal Menambahakan Produk! Coba lagi nanti.",
              style: TextStyle(
                fontSize: size.height * p1,
                color: Colors.red,
              ),
            ),
          ),
          Gap(size.height * 0.03),
        ],
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    String newText = idCurrencyFormat.format(value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
