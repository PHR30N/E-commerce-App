import 'package:e_commerce_app/app/routing/routes.dart';
import 'package:e_commerce_app/presentaion/cubit/app_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 202, 234),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 161, 202, 234),

        title: const Text("Home Page",style: TextStyle(
          color: Colors.black,
        ),),
        centerTitle: true,
       
        
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Image.asset(
                'assets/images/clothes.png',
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Center(
              child: OutlinedButton(
                onPressed: () {
                  context.pushNamed(Routes.productPage);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    "View Products",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
