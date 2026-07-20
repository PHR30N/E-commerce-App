import 'package:e_commerce_app/app_theme.dart';
import 'package:e_commerce_app/app_theme_cubit.dart';
import 'package:e_commerce_app/app_theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'App_Router.dart';
import 'Home_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
 Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppThemeCubit(),
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'E-Commerce App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}