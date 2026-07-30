import 'package:e_commerce_app/app/routing/routes.dart';
import 'package:e_commerce_app/presentaion/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/category_cubit.dart';
import '../cubit/category_state.dart';
import '../../domain/models/category_model.dart';

class CategoryPage extends StatefulWidget {
  final CategoryModel category;

  const CategoryPage({
    super.key,
    required this.category,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    final query = widget.category.name.isNotEmpty
        ? widget.category.name
        : widget.category.id;
    context.read<CategoryCubit>().getProductsByCategory(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CategoryFailure) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is CategorySuccess) {
            final products = state.products;

            if (products.isEmpty) {
              return const Center(
                child: Text("No Products"),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .65,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    context.pushNamed(
                      Routes.detailsPage,
                      queryParameters: {
                        "id": product.id,
                        "name": product.name,
                      },
                    );
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.coverPictureUrl,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${product.price}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.add_shopping_cart,
                                  color: Color(0xFF2E5B5E),
                                  size: 20,
                                ),
                                onPressed: () {
                                  context.read<CartCubit>().addToCart(
                                        productId: product.id,
                                        quantity: 1,
                                      );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("${product.name} added to cart"),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text("Loading Products..."),
          );
        },
      ),
    );
  }
}