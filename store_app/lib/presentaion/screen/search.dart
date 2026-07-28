import 'package:e_commerce_app/app/routing/routes.dart';
import 'package:e_commerce_app/domain/models/category_model.dart';
import 'package:e_commerce_app/presentaion/cubit/category_cubit.dart';
import 'package:e_commerce_app/presentaion/cubit/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}
class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategories();
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
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
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search Category...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is CategoryFailure) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    if (state is CategoriesFetchSuccess) {
                      final allCategories = state.categories;
                      final filteredCategories = allCategories.where((cat) {
                        return cat.name
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase());
                      }).toList();

                      if (filteredCategories.isEmpty) {
                        return const Center(
                          child: Text("No categories found"),
                        );
                      }

                      return ListView.separated(
                        itemCount: filteredCategories.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final category = filteredCategories[index];

                          return ListTile(
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            leading: const Icon(Icons.category_outlined),
                            title: Text(
                              category.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 16),
                            onTap: () {
                              context.pushNamed(
                                Routes.category,
                                extra: category,
                              );
                            },
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
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