import 'package:elysia/core/config/font_size.dart';
import 'package:elysia/features/cart/persentation/view/cart.dart';
import 'package:elysia/features/product/persentation/view/product.dart';
import 'package:elysia/features/stock/persentation/view/stock.dart';
import 'package:elysia/pages/home_fragment.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  int currentIndex = 0;

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
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeFragment(),
          StockFragment(),
          ProductFragment(),
          CartFragment(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        unselectedFontSize: size.height * p1,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          setState(() {
            pageController.jumpToPage(index);
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home_rounded),
          ),
          BottomNavigationBarItem(
            label: "Stok",
            icon: Icon(Icons.warehouse_rounded),
          ),
          BottomNavigationBarItem(
            label: "Produk",
            icon: Icon(Icons.grid_view_rounded),
          ),
          BottomNavigationBarItem(
            label: "Keranjang",
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
    );
  }
}
