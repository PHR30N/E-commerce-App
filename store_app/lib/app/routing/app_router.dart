import 'package:e_commerce_app/core/constant/local_key.dart';
import 'package:e_commerce_app/core/local_storage/base_local_storage.dart';
import 'package:e_commerce_app/domain/models/category_model.dart';
import 'package:e_commerce_app/domain/repos/category_repo.dart';
import 'package:e_commerce_app/domain/repos/products_repo.dart';
import 'package:e_commerce_app/injection_container.dart';
import 'package:e_commerce_app/presentaion/cubit/category_cubit.dart';
import 'package:e_commerce_app/presentaion/cubit/register_cubit.dart';
import 'package:e_commerce_app/presentaion/cubit/verify_email_cubit.dart';
import 'package:e_commerce_app/presentaion/screen/category_page.dart';
import 'package:e_commerce_app/presentaion/screen/first_page.dart';
import 'package:e_commerce_app/presentaion/screen/Product_Page.dart';
import 'package:e_commerce_app/app/routing/routes.dart';
import 'package:e_commerce_app/presentaion/screen/cart_page.dart';
import 'package:e_commerce_app/presentaion/screen/onboarding_page.dart';
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
  static final BaseLocalStorage? localStorage = getIt<BaseLocalStorage>();
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: Routes.onboardingPage,
        redirect: (context, state) async {
          // 1. Fetch value safely
          final isOpen = await localStorage?.getBool(LocalKey.isOpen) ?? false;

          // 2. If onboarding was completed, redirect to Auth screen
          if (isOpen) {
            return '/${Routes.auth}';
          }

          // 3. Return null so GoRouter stays on OnboardingPage
          return null;
        },
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/${Routes.auth}',
        name: Routes.auth,
        builder: (context, state) => const AuthPage(),
      ),

      GoRoute(
        path: '/${Routes.loginPage}',
        name: Routes.loginPage,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: '/${Routes.registerPage}',
        name: Routes.registerPage,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<RegisterCubit>(),
          child: const RegisterPage(),
        ),
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
GoRoute(
  path: '/${Routes.category}',
  name: Routes.category,
  builder: (context, state) {
    final category = state.extra as CategoryModel;
    return BlocProvider(
      create: (context) => CategoryCubit(getIt<CategoriesRepo>()),
      child: CategoryPage(category: category),
    );
  },
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
            builder: (context, state) {
              final email = state.extra as String? ?? '';
              return BlocProvider(
                create: (context) => getIt<VerifyEmailCubit>(),
                child: VerificationPage(email: email),
              );
            },
          ),
        ],
      ),
    ],
  );
}