import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otlop_app/cubits/cubit_states.dart';
import 'package:otlop_app/cubits/product_cubit.dart';
import 'package:otlop_app/screens/filter_by_category/filter_categoty.dart';
import 'package:otlop_app/widgets/brand_category.dart';
import 'package:otlop_app/helpers/colors.dart';
import 'package:otlop_app/widgets/category_card.dart';

import '../../cubits/brand_cubit.dart';
import '../../cubits/brand_states.dart';
import '../../cubits/cart_cubit.dart';
import '../../cubits/category_cubit.dart';
import '../../cubits/category_states.dart';
import '../../widgets/product_card.dart';
import '../details_screen/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good evening 🥐',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),

                Row(
                  children: [
                    const Text(
                      'OTLOP',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/Symbol.svg',
                        height: 25,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    height: 35,
                    width: 200,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5F3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset('assets/icons/location.svg'),
                        const Flexible(
                          child: Text(
                            '14 Tahrir Square, Cairo',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SvgPicture.asset('assets/icons/arrow_under.svg'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                SizedBox(
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF9CA3AF),
                      ),
                      hintText: 'Search coffee, cakes, donuts...',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 13,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.filter_alt,
                          color: Color(primarycolor),
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(primarycolor)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'See all',
                      style: TextStyle(color: Color(primarycolor)),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                BlocBuilder<CategoryCubit, CategoryStates>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color(primarycolor),
                        ),
                      );
                    }

                    if (state is CategorySuccess) {
                      return SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            final category = state.categories[index];

                            return CategoryCard(
                              catImage: category['pictureUrl'] ?? '',
                              name: category['name'] ?? '',
                              onTap: () {
                                final productState =
                                    context.read<ProductCubit>().state;

                                if (productState is ProductSuccess) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FilterScreen(
                                        items: productState.products,
                                        filterValue: category['name'].toString(),
                                        isCategory: true,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      );
                    }

                    return const Text('Failed to load categories');
                  },
                ),

                const SizedBox(height: 25),

                const Text(
                  'Brands',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                BlocBuilder<BrandCubit, BrandStates>(
                  builder: (context, state) {
                    if (state is BrandLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color(primarycolor),
                        ),
                      );
                    }

                    if (state is BrandSuccess) {
                      return SizedBox(
                        height: 45,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.brands.length,
                          itemBuilder: (context, index) {
                            final brand = state.brands[index];

                            return BrandCategory(
                              brand: brand['name'] ?? '',
                              onTap: () {
                                final productState =
                                    context.read<ProductCubit>().state;

                                if (productState is ProductSuccess) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FilterScreen(
                                        items: productState.products,
                                        filterValue: brand['name'].toString(),
                                        isCategory: false,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      );
                    }

                    return const Text('Failed to load brands');
                  },
                ),

                const SizedBox(height: 20),

                const Text(
                  'Popular right now',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF191F2D),
                  ),
                ),

                const SizedBox(height: 20),

                BlocBuilder<ProductCubit, ProductStates>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color(primarycolor),
                        ),
                      );
                    }
                    if (state is ProductSuccess) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.products.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.56,
                        ),
                        itemBuilder: (context, index) {
                          final product = state.products[index];

                          return ProductCard(
                            image: product.pictureUrl,
                            category: product.category,
                            restaurant: product.brand,
                            name: product.name,
                            price: product.price.toString(),

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(product: product),
                                ),
                              );
                            },

                            onAdd: () {
                              context.read<CartCubit>().addProduct(product);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${product.name} added to cart'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }

                    return const Center(
                      child: Text('Failed to load products'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
