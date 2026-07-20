import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/Home_Page.dart';
import 'package:store_app/Login_Page.dart';
import 'package:store_app/Product_Details.dart';
import 'package:store_app/product_model.dart';
import 'package:store_app/Product_Page.dart';
import 'package:store_app/Register_Page.dart';

class AppRouter {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
      ),
       GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/product',
      builder: (context, state) => const ProductPage(products: [],),
    ),
    GoRoute(
  path: '/details',
  builder: (context, state) {
    final product = state.extra as ProductModel;
    return ProductDetailsPage(product: product);
  },
),
    ],
  );
}
