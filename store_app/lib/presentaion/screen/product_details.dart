import '../cubit/home_cubit.dart';
import 'package:e_commerce_app/presentaion/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  final String id ;
  final String name;

  const ProductDetailsPage({super.key, required this.id, required this.name});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getProductById(id: widget.id, );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: const Color.fromARGB(255, 161, 202, 234),

      appBar: AppBar(title: Text(widget.name ), centerTitle: true),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch(state){
            GetProductByIdLoadingState() => const Center(child: CircularProgressIndicator()),
            GetProductByIdFailureState(:final message, ) => Center(child: Text(message)),
            GetProductByIdSuccessState(: final product,)=>
            SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.coverPictureUrl,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),

            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "${product.price} EGP",
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(product.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
      _=> SizedBox(),
};
          },
          ),
    );
  }
}