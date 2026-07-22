
import 'package:e_commerce_app/app/routing/Routes.dart';
import 'package:e_commerce_app/presentaion/cubit/app_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/home_cubit.dart'; 
import '../cubit/home_state.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
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
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state) {
            GetProductsLoadingState() => const Center(child: CircularProgressIndicator()),
            GetProductsFailureState(:final message) => Center(child: Text(message)),
            GetProductsSuccessState(:final response) => Padding(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  itemCount: response.items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final product = response.items[index];
                    return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                context.pushNamed(
                  Routes.detailsPage,
                  queryParameters: {"id":product.id,"name":product.name},
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.network(
                        product.coverPictureUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            size: 60,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "${product.price} EGP",
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
                  },
                ),
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}