import 'package:e_commerce_app/domain/repos/products_repo.dart';
import 'package:e_commerce_app/injection_container.dart';
import 'package:e_commerce_app/presentaion/screen/Product_Page.dart';
import 'package:e_commerce_app/app/routing/Routes.dart';
import 'package:e_commerce_app/presentaion/screen/cart_page.dart';
import 'package:e_commerce_app/presentaion/screen/search.dart';
import 'package:e_commerce_app/presentaion/screen/settings_page.dart';
import '../../presentaion/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../presentaion/screen/home_page.dart';
import '../../presentaion/screen/login_page.dart';
import '../../presentaion/screen/product_details.dart';
import '../../presentaion/screen/register_page.dart';
import '../../presentaion/screen/main_layout.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BlocProvider(
            create: (context) => HomeCubit(productsRepo: getIt<ProductsRepo>()),
            child: MainLayout(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${Routes.homePage}',
                name: Routes.homePage,
                builder: (BuildContext context, GoRouterState state) =>
                    HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${Routes.search}',
                name: Routes.search,
                builder: (BuildContext context, GoRouterState state) =>
                    Search(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${Routes.cartPage}',
                name: Routes.cartPage,
                builder: (BuildContext context, GoRouterState state) =>
                    CartPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${Routes.settings}',
                name: Routes.settings,
                builder: (BuildContext context, GoRouterState state) =>
                    const SettingsPage(),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: "/",
        name: Routes.loginPage,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: "/${Routes.registerPage}",
        name: Routes.registerPage,
        builder: (context, state) => const RegisterPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => HomeCubit(productsRepo: getIt<ProductsRepo>()),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: "/${Routes.productPage}",
            name: Routes.productPage,
            builder: (context, state) {
              return ProductPage();
            },
          ),
          GoRoute(
            path: "/${Routes.detailsPage}",
            name: Routes.detailsPage,
            builder: (context, state) {
              return ProductDetailsPage(
                id: state.uri.queryParameters["id"] ?? "",
                name: state.uri.queryParameters["name"] ?? "",
              );
            },
          ),
        ],
      ),
    ],
  );
}
