import 'package:elysia/common/dummy_data.dart';
import 'package:elysia/core/config/font_size.dart';
import 'package:elysia/features/stock/application/stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

final nameControllerProv = StateProvider.autoDispose<TextEditingController>(
    (ref) => TextEditingController());
final qtyControllerProv = StateProvider.autoDispose<TextEditingController>(
    (ref) => TextEditingController());
final weightControllerProv = StateProvider.autoDispose<TextEditingController>(
    (ref) => TextEditingController());

final dropdownValueController = StateProvider.autoDispose<String>(
  (ref) => listAttr.first,
);

final isLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);

final isStockErrorProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

class StockForm extends ConsumerWidget {
  const StockForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Aplikasi Toko",
          style: TextStyle(
            fontSize: size.height * h1,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(size.height * 0.025),
            Container(
              padding: EdgeInsets.fromLTRB(
                0,
                size.height * 0.005,
                0,
                size.height * 0.005,
              ),
              color: Colors.green,
              child: Center(
                child: Text(
                  "Tambah produk",
                  style: TextStyle(
                    fontSize: size.height * h2,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Gap(size.height * 0.025),

            /// form
            const FormStock()
          ],
        ),
      ),
    );
  }
}

class FormStock extends ConsumerWidget {
  const FormStock({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    String dropdownValue = ref.watch(dropdownValueController);
    final nameController = ref.watch(nameControllerProv);
    final qtyController = ref.watch(qtyControllerProv);
    final weightController = ref.watch(weightControllerProv);

    final isLoading = ref.watch(isLoadingProvider);
    final isStockError = ref.watch(isStockErrorProvider);

    final formKey = GlobalKey<FormState>();

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
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: "Nama Produk",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value == "") {
                  return "Nama Produk harus diisi";
                }

                return null;
              },
            ),
            Gap(size.height * 0.025),
            TextFormField(
              controller: qtyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Jumlah Produk",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value == "") {
                  return "Jumlah Produk harus diisi";
                }

                return null;
              },
            ),
            Gap(size.height * 0.025),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Berat Satuan",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Berat produk harus diisi";
                      }

                      return null;
                    },
                  ),
                ),
                Gap(size.width * 0.06),
                SizedBox(
                  width: size.width * 0.25,
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    onChanged: (String? value) {
                      ref.read(dropdownValueController.notifier).state = value!;
                    },
                    items: listAttr.map<DropdownMenuItem<String>>(
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
            ErrorCondition(isStockError: isStockError, size: size),
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
                    StockApplication().stock(
                      context: context,
                      size: size,
                      name: nameController.text,
                      qty: int.parse(qtyController.text),
                      attr: dropdownValue,
                      weight: int.parse(weightController.text),
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
                        "Tambah Produk",
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
    required this.isStockError,
    required this.size,
  });

  final bool isStockError;
  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: isStockError,
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
              "Gagal Menambahakan Stok! Coba lagi nanti.",
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
