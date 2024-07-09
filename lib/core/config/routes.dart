import 'package:elysia/features/product/persentation/view/product_form.dart';
import 'package:elysia/features/sales/persentation/view/sales.dart';
import 'package:elysia/features/stock/persentation/view/stock_form.dart';
import 'package:elysia/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String home = "home";
  static const String stockForm = "stock-form";
  static const String productForm = "product-form";
  static const String salesForm = "sales-form";

  static final GoRouter goRouter = GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(
        name: home,
        path: '/home',
        pageBuilder: _homePageBuilder,
      ),
      GoRoute(
        name: stockForm,
        path: '/stock-form',
        pageBuilder: _stockFormPageBuilder,
      ),
      GoRoute(
        name: productForm,
        path: '/product-form',
        pageBuilder: _productFormPageBuilder,
      ),
      GoRoute(
        name: salesForm,
        path: '/sales-form',
        pageBuilder: _salesFormPageBuilder,
      ),
    ],
  );

  void clearAndNavigate(String name) {
    while (goRouter.canPop() == true) {
      goRouter.pop();
    }
    goRouter.pushReplacementNamed(name);
  }

  static Page _homePageBuilder(context, state) {
    return transition(
      child: const HomePage(),
    );
  }

  static Page _stockFormPageBuilder(context, state) {
    return transition(
      child: const StockForm(),
    );
  }

  static Page _productFormPageBuilder(context, state) {
    return transition(
      child: const ProductForm(),
    );
  }

  static Page _salesFormPageBuilder(context, state) {
    return transition(
      child: const SalesPage(),
    );
  }

  static transition({required Widget child}) {
    return CustomTransitionPage(
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: child,
    );
  }
}
