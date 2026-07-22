import 'package:e_commerce_app/domain/repos/products_repo.dart';
import 'package:e_commerce_app/injection_container.dart';
import 'package:e_commerce_app/presentaion/screen/First_Page.dart';
import 'package:e_commerce_app/presentaion/screen/Product_Page.dart';
import 'package:e_commerce_app/app/routing/Routes.dart';
import 'package:e_commerce_app/presentaion/screen/cart_page.dart';
import 'package:e_commerce_app/presentaion/screen/search.dart';
import 'package:e_commerce_app/presentaion/screen/settings_page.dart';
import 'package:e_commerce_app/presentaion/screen/verify_Page.dart';
import '../../presentaion/cubit/home_cubit.dart';
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
      // أول صفحة
      GoRoute(
        path: '/',
        builder: (context, state) => const AuthPage(),
      ),

      // Login
      GoRoute(
        path: '/login',
        name: Routes.loginPage,
        builder: (context, state) => const LoginPage(),
      ),

      // Register
      GoRoute(
        path: '/register',
        name: Routes.registerPage,
        builder: (context, state) => const RegisterPage(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BlocProvider(
            create: (context) =>
                HomeCubit(productsRepo: getIt<ProductsRepo>()),
            child: MainLayout(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${Routes.homePage}',
                name: Routes.homePage,
                builder: (context, state) => HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${Routes.search}',
                name: Routes.search,
                builder: (context, state) => Search(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${Routes.cartPage}',
                name: Routes.cartPage,
                builder: (context, state) => CartPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${Routes.settings}',
                name: Routes.settings,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),

      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) =>
                HomeCubit(productsRepo: getIt<ProductsRepo>()),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/${Routes.productPage}',
            name: Routes.productPage,
            builder: (context, state) => ProductPage(),
          ),
          GoRoute(
            path: '/${Routes.detailsPage}',
            name: Routes.detailsPage,
            builder: (context, state) => ProductDetailsPage(
              id: state.uri.queryParameters["id"] ?? "",
              name: state.uri.queryParameters["name"] ?? "",
            ),
          ),
          GoRoute(
            path: '/verification',
            builder: (context, state) => const VerificationPage(),
          ),
        ],
      ),
    ],
  );
}