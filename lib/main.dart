import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlop_app/cubits/product_cubit.dart';
import 'package:otlop_app/cubits/cart_cubit.dart';
import 'package:otlop_app/screens/log_in_screen/log_in_screen.dart';
import 'cubits/brand_cubit.dart';
import 'cubits/category_cubit.dart';

void main() {
  runApp(const OtlopApp());
}

class OtlopApp extends StatelessWidget {
  const OtlopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit()..getProducts(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit()..getCategories(),
        ),
        BlocProvider(
          create: (context) => BrandCubit()..getBrands(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}