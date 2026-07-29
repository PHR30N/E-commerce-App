import 'package:e_commerce_app/app/routing/routes.dart';
import 'package:e_commerce_app/presentaion/cubit/auth_cubit.dart';
import 'package:e_commerce_app/presentaion/cubit/auth_state.dart';
import 'package:e_commerce_app/presentaion/cubit/verify_email_cubit.dart';
import 'package:e_commerce_app/presentaion/cubit/verify_email_state.dart';
import 'package:e_commerce_app/presentaion/screen/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerificationPage extends StatefulWidget {
  final String email;

  const VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerifySuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Email Verified Successfully")));

          context.go('/${Routes.homePage}');
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context,state){
        final isLoading = state is AuthLoading;
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 161, 202, 234),

        appBar: AppBar(
          title: const Text("Verify Email"),
          backgroundColor: const Color.fromARGB(255, 161, 202, 234),
        ),

        body: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                "Enter OTP sent to\n${widget.email}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 30),

              TextField(
  controller: otpController,
  keyboardType: TextInputType.number,
  textAlign: TextAlign.center,
  maxLength: 6,
  autofillHints: null, 
  decoration: InputDecoration(
    filled: true,     
    fillColor: Colors.white,
    hintText: "OTP",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed:isLoading?null:(){ final otp = otpController.text.trim();
                            if (otp.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please enter the OTP"),
                                ),
                              );
                              return;
                            }
                    context.read<AuthCubit>().verify(
                      email: widget.email,
                      otp: otp,
                    );
                  },
                  child: const Text(
                    'Verify',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      },
  );
  }
}
