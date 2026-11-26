import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlop_app/cubits/cart_cubit.dart';
import 'package:otlop_app/cubits/cart_states.dart';
import 'package:otlop_app/widgets/cart_product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartProducts = state.products;
        final quantities = state.quantities;

        return Scaffold(
          backgroundColor: const Color(0xffE5E5E5),
          body: Column(
            children: [
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  color: const Color(0xffF8F9FB),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 34, 13, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Cart',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff10213A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${quantities.fold<int>(0, (sum, quantity) => sum + quantity)} items · ${state.total} EGP',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 18),

                        if (cartProducts.isEmpty)
                          const Expanded(
                            child: Center(
                              child: Text(
                                'Your cart is empty',
                                style: TextStyle(
                                  color: Color(0xff9CA3AF),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        else ...[
                          SizedBox(
                            height: 300,
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: cartProducts.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 12);
                              },
                              itemBuilder: (context, index) {
                                return CartProductCard(
                                  product: cartProducts[index],
                                  quantity: quantities[index],
                                  onIncrease: () {
                                    context
                                        .read<CartCubit>()
                                        .increase(index);
                                  },
                                  onDecrease: () {
                                    context
                                        .read<CartCubit>()
                                        .decrease(index);
                                  },
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 14),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Order summary',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff10213A),
                                  ),
                                ),
                                const SizedBox(height: 18),

                                _summaryRow(
                                  'Subtotal',
                                  '${state.subtotal} EGP',
                                ),

                                const SizedBox(height: 12),

                                _summaryRow(
                                  'Delivery fee',
                                  '${state.deliveryFee} EGP',
                                ),

                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Divider(
                                    color: Color(0xffF3F4F6),
                                    height: 1,
                                  ),
                                ),

                                _summaryRow(
                                  'Total',
                                  '${state.total} EGP',
                                  isTotal: true,
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: cartProducts.isEmpty
                                  ? null
                                  : () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Checkout coming soon'),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffF45135),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Proceed to Checkout · ${state.total} EGP',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _summaryRow(
      String title,
      String value, {
        bool isTotal = false,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal
                ? const Color(0xff10213A)
                : const Color(0xff9CA3AF),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: FontWeight.bold,
            color: isTotal
                ? const Color(0xffF45135)
                : const Color(0xff10213A),
          ),
        ),
      ],
    );
  }
}