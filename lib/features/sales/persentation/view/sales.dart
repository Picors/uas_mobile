import 'package:elysia/core/config/font_size.dart';
import 'package:elysia/features/sales/persentation/view/sales_form.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
      body: Column(
        children: [
          Gap(size.height * 0.025),
          const SalesForm(),
        ],
      ),
    );
  }
}
