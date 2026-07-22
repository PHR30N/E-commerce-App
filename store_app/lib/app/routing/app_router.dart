import 'package:e_commerce_app/domain/repos/products_repo.dart';
import 'package:e_commerce_app/injection_container.dart';
import 'package:e_commerce_app/presentaion/screen/Product_Page.dart';
import 'package:e_commerce_app/app/routing/Routes.dart';
import '../../presentaion/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../presentaion/screen/Home_Page.dart';
import '../../presentaion/screen/Login_Page.dart';
import '../../presentaion/screen/Product_Details.dart';
import '../../presentaion/screen/Register_Page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name:Routes.homePage,
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
      ),
       GoRoute(
      path: "/${Routes.loginPage}",
        name:Routes.loginPage,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: "/${Routes.registerPage}",
        name:Routes.registerPage,
      builder: (context, state) => const RegisterPage(),
    ),
ShellRoute(
      builder: (context,state,child){
        return BlocProvider(
          create: (context)=>HomeCubit(productsRepo: getIt<ProductsRepo>()),
          child: child,
        );
      },
      routes: [
    GoRoute(path: "/${Routes.productPage}",
    name: Routes.productPage,
    builder: (context,state){
    return ProductPage();
    },
    ),
    GoRoute(path: "/${Routes.detailsPage}",
    name: Routes.detailsPage,
    builder: (context,state){
    return ProductDetailsPage(id: state.uri.queryParameters["id"] ?? "",name: state.uri.queryParameters["name"] ?? "");
    },
    ),
    ],
    ),
    ],
  );
}
