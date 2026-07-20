import 'package:e_commerce_app/Product_Page.dart';
import 'package:e_commerce_app/Routes.dart';
import 'package:e_commerce_app/api_service.dart';
import 'package:e_commerce_app/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'Home_Page.dart';
import 'Login_Page.dart';
import 'Product_Details.dart';
import 'Register_Page.dart';

class AppRouter {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name:Routes.HomePage,
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
      ),
       GoRoute(
      path: "/${Routes.LoginPage}",
        name:Routes.LoginPage,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: "/${Routes.RegisterPage}",
        name:Routes.RegisterPage,
      builder: (context, state) => const RegisterPage(),
    ),
ShellRoute(
      builder: (context,state,child){
        return BlocProvider(
          create: (context)=>HomeCubit(apiService: ApiService()),
          child: child,
        );
      },
      routes: [
    GoRoute(path: "/${Routes.ProductPage}",
    name: Routes.ProductPage,
    builder: (context,state){
    return ProductPage();
    },
    ),
    GoRoute(path: "/${Routes.DetailsPage}",
    name: Routes.DetailsPage,
    builder: (context,state){
    return ProductDetailsPage(id: state.uri.queryParameters["id"] ?? "",name: state.uri.queryParameters["name"] ?? "");
    },
    ),
    ],
    ),
    ],
  );
}
