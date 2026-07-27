import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    context.read<CategoryCubit>().getProductsByCategory(
      widget.category.name,
    );
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


            if(products.isEmpty){

              return const Center(
                child: Text("No Products"),
              );

            }



            return GridView.builder(

              padding: const EdgeInsets.all(16),


              itemCount: products.length,


              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 2,

                crossAxisSpacing: 10,

                mainAxisSpacing: 10,

                childAspectRatio: .65,

              ),



              itemBuilder: (context, index) {


                final product = products[index];


                return Card(

                  child: Padding(

                    padding: const EdgeInsets.all(8),

                    child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment.start,


                      children: [


                        Expanded(

                          child: Image.network(

                            product.coverPictureUrl,

                            width: double.infinity,

                            fit: BoxFit.contain,


                            errorBuilder:
                                (context, error, stackTrace) {

                              return const Icon(
                                Icons.image_not_supported,
                              );

                            },

                          ),

                        ),



                        const SizedBox(height: 10),



                        Text(

                          product.name,

                          maxLines: 2,

                          overflow:
                          TextOverflow.ellipsis,

                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),

                        ),



                        const SizedBox(height: 5),



                        Text(

                          "\$${product.price}",

                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),

                        ),


                      ],

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