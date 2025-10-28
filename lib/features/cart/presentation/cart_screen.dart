import 'package:amar_shoday/core/constants/colors.dart';
import 'package:amar_shoday/core/routes/route_names.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Red Chilli Powder',
      'price': 200,
      'qty': 2,
      'image': 'assets/red_chilli_mix.png',
      'weight': '200 gm',
      'offer': '20 tak off',
    },
    {
      'name': 'Soyabin Oil',
      'price': 999,
      'qty': 5,
      'image': 'assets/soyabin.png',
      'weight': '5 liter',
      'offer': null,
    },
    {
      'name': 'Aarong Dairy Pasteurized Liquid Milk',
      'price': 105,
      'qty': 5,
      'image': 'assets/aarong_milk.png',
      'weight': '1 liter',
      'offer': null,
    },
  ];

  bool isExpanded = false;

  double get total {
    return cartItems.fold<double>(
      0,
      (sum, item) =>
          sum + ((item['price'] as num).toDouble() * (item['qty'] as int)),
    );
  }

  void incrementQty(int index) {
    setState(() => cartItems[index]['qty']++);
  }

  void decrementQty(int index) {
    setState(() {
      if (cartItems[index]['qty'] > 1) {
        cartItems[index]['qty']--;
      }
    });
  }

  void removeItem(int index) {
    setState(() => cartItems.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Image.asset('assets/cart.png', width: 28, height: 28),
            const SizedBox(width: 10),
            Text(
              'cart'.tr(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: Colors.black12),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                ...List.generate(cartItems.length, (index) {
                  final item = cartItems[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  item['image'] as String,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item['name'] as String,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '\$${(item['price'] as num).toDouble().toStringAsFixed(2)} | ${item['weight']}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    if ((item['offer'] as String?) != null)
                                      Text(
                                        item['offer'] as String,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 36,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryColor,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: Colors.green.shade200,
                                          width: 1),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          splashRadius: 16,
                                          iconSize: 16,
                                          onPressed: () => decrementQty(index),
                                          icon: const Icon(Icons.remove),
                                          color: Colors.white,
                                        ),
                                        Text(
                                          '${item['qty']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                        IconButton(
                                          splashRadius: 16,
                                          iconSize: 16,
                                          onPressed: () => incrementQty(index),
                                          icon: const Icon(Icons.add),
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  TextButton(
                                    onPressed: () => removeItem(index),
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(2),
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Image.asset(
                                      'assets/delete.png',
                                      width: 14,
                                      height: 14,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.black12,
                          indent: 12,
                          endIndent: 12,
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 8),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                          'Navigate to Add More Items screen',
                          style: TextStyle(color: Colors.black),
                        )),
                      );
                    },
                    child: const Row(
                      children: [
                        SizedBox(width: 30),
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.add, color: Colors.white, size: 18),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Add More items',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, thickness: 1, color: Colors.black12),

                // Dropdown Section
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'If any product is not available',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isExpanded
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            onPressed: () =>
                                setState(() => isExpanded = !isExpanded),
                          ),
                        ],
                      ),
                      if (isExpanded) ...[
                        const SizedBox(height: 8),
                        ...[
                          "Remove it from my cart",
                          "I'll wait until it's restocked",
                          "Please Cancel the order",
                          "Call me ASAP",
                          "Notify me when it's back",
                        ].map((option) {
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                    color: Colors.black, width: 1.2),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  option,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                  'Response submitted',
                                  style: TextStyle(color: Colors.black),
                                )),
                              );
                              setState(() => isExpanded = false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  color: Colors.green, width: 1),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          SizedBox(
            width: 335,
            child: ElevatedButton(
              onPressed: cartItems.isEmpty
                  ? null
                  : () {
                      Navigator.pushReplacementNamed(context, RouteNames.order);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(
                      //       'Continuing to checkout... (৳ ${total.toStringAsFixed(2)})',
                      //       style: const TextStyle(color: Colors.black),
                      //     ),
                      //   ),
                      // );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                'Continue Checkout (৳ ${total.toStringAsFixed(2)})',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
