import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/Routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const SizedBox(height: 30),

                    const Text(
                      "Welcome to Faster.",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: "WorkSans",
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

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: emailController,
                      style: const TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        if (!value.contains("@")) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value;
                      },
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: passwordController,
                      style: const TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value;
                      },
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "WorkSans",
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            print(email);
                            print(password);

                            context.go(Routes.ProductPage);
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "WorkSans",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                   
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
}
