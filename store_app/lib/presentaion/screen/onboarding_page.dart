import 'package:e_commerce_app/app/routing/routes.dart';
import 'package:e_commerce_app/core/local_storage/base_local_storage.dart';
import 'package:e_commerce_app/injection_container.dart';
import 'package:flutter/material.dart' hide LocalKey;
import 'package:go_router/go_router.dart';
import '../../core/constant/local_key.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();
  int _currentPage = 0;
  final BaseLocalStorage localStorage = getIt<BaseLocalStorage>();
  Future<void> completeOnboarding() async {
    await localStorage.setBool(LocalKey.isOpen, true);
    if (!mounted) return;
    context.goNamed(Routes.auth);
  }
  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Discover Products',
      'description': 'Explore thousands of products with top quality and best prices.',
      'image': 'assets/images/banner_1.jpg',
    },
    {
      'title': 'Easy Payment',
      'description': 'Fast and secure payment options for a seamless checkout.',
      'image': 'assets/images/image_1.jpg',
    },
    {
      'title': 'Fast Delivery',
      'description': 'Get your orders delivered right to your doorstep quickly.',
      'image': 'assets/images/banner_3.jpg',
    },
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 202, 234),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  completeOnboarding();
                  context.goNamed(Routes.auth);
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = _onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          item['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item['description']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color(0xFF7A9E9F)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
  child: SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: () {
        if (_currentPage == _onboardingData.length - 1) {
          completeOnboarding();
        } else {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        _currentPage == _onboardingData.length - 1
            ? "Get Started"
            : "Next",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ),
  ),
)
          ],
        ),
      ),
    );
  }
}