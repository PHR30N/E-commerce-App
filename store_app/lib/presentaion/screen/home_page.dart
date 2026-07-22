import 'package:e_commerce_app/app/routing/routes.dart';
import 'package:e_commerce_app/presentaion/cubit/app_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        actions: [
    IconButton(
      icon: Icon(
        context.watch<AppThemeCubit>().state.isDark
            ? Icons.light_mode
            : Icons.dark_mode,
      ),
      onPressed: () {
        context.read<AppThemeCubit>().toggleTheme();
      },
    ),
  ],
      ),
      backgroundColor: const Color.fromARGB(255, 161, 202, 234),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: ElevatedButton.icon(onPressed: (){context.pushNamed(Routes.productPage);}, label: Text("View prodects",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.green),)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
