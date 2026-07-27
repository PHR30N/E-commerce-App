import 'package:e_commerce_app/core/network/apis/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation<double> _fade;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    _redirect();
  }



  Future<void> _redirect() async {

    final minDelay = Future.delayed(
      const Duration(milliseconds: 1600),
    );


    final isFirstLaunch =
        await LocalStorageService.instance.isFirstLaunch();


    await minDelay;


    if (!mounted) return;


    if (isFirstLaunch) {

      await LocalStorageService.instance
          .setFirstLaunchComplete();

    }


    // بدل Navigator
    context.go('/first');

  }



  @override
  void dispose() {

    _controller.dispose();

    super.dispose();

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: Center(

        child: FadeTransition(

          opacity: _fade,

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              RichText(

                text: const TextSpan(

                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),

                  children: [

                    TextSpan(
                      text: 'Hyper',
                      style: TextStyle(
                        color: Color(0xFFF5A623),
                      ),
                    ),

                    TextSpan(
                      text: 'Mart',
                      style: TextStyle(
                        color: Color(0xFF2FAE8C),
                      ),
                    ),

                  ],

                ),

              ),


              const SizedBox(height:16),


              const CircularProgressIndicator(

                color: Color(0xFF2FAE8C),

                strokeWidth: 2.5,

              ),

            ],

          ),

        ),

      ),

    );

  }

}