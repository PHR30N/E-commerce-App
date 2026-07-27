import 'package:e_commerce_app/app/routing/routes.dart';
import 'package:e_commerce_app/domain/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  final List<String> categories = const [
    'pearl earrings',
    'gold necklace',
    'tommy hilfiger',
    'gucci',
    'balenciaga',
    'diamond necklace',
    'modern ring',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 202, 234),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final categoryName = categories[index];

                    return ListTile(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      leading: const Icon(Icons.category_outlined),
                      title: Text(
                        categoryName.split(' ').map((word) => word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1)}').join(' '),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        final selectedCategory = CategoryModel(
                          name: categoryName, 
                          iconAsset: 'default',
                        );

                        context.pushNamed(
                          Routes.category,
                          extra: selectedCategory,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}