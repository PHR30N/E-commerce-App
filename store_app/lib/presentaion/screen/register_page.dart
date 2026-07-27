import 'package:e_commerce_app/presentaion/cubit/register_cubit.dart';
import 'package:e_commerce_app/presentaion/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? email;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          context.push("/verification", extra: email);
        }

        if (state is RegisterFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },

      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 161, 202, 234),

        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,

                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    children: [
                      const Text(
                        "Welcome to Faster.",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 30),
socialButton(
                      Icons.g_mobiledata,
                      "Login with Google",
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "WorkSans",
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    socialButton(
                      Icons.apple,
                      "Login with Apple",
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "WorkSans",
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    socialButton(
                      Icons.facebook,
                      "Login with Facebook",
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "WorkSans",
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "or by email",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "WorkSans",
                        ),
                      ),
                    ),
                      TextFormField(
                        controller: firstNameController,
                        decoration: inputDecoration("First Name"),
                        validator: requiredValidator,
                      ),

                      const SizedBox(height: 15),

                      TextFormField(
                        controller: lastNameController,
                        decoration: inputDecoration("Last Name"),
                        validator: requiredValidator,
                      ),

                      const SizedBox(height: 15),

                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: inputDecoration("Email Address"),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }

                          if (!value.contains("@")) {
                            return "Enter valid email";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      TextFormField(
                        controller: passwordController,

                        obscureText: true,

                        decoration: inputDecoration("Password"),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }

                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,

                        height: 55,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),

                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              email = emailController.text;

                              context.read<RegisterCubit>().register(
                                email: emailController.text,

                                password: passwordController.text,

                                firstName: firstNameController.text,

                                lastName: lastNameController.text,
                              );
                            }
                          },

                          child: const Text(
                            "Sign Up",

                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is required";
    }

    return null;
  }
}
Widget socialButton(IconData icon, String text, {TextStyle? style}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.white),
        ),
        onPressed: () {},
        icon: Icon(icon),
        label: Text(
          text,
          style:
              style ??
              const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "WorkSans",
              ),
        ),
      ),
    );
  }

