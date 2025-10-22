import 'package:amar_shoday/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Sample cart items
  List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Red Chilli Powder',
      'price': 200, // int
      'qty': 2,
      'image': 'assets/red_chilli_mix.png',
      'weight': '200 gm',
      'offer': '20 tak off',
    },
    {
      'name': 'Soyabin Oil',
      'price': 999, // int
      'qty': 5,
      'image': 'assets/soyabin.png',
      'weight': '5 liter',
      'offer': null,
    },
    {
      'name': 'Aarong Dairy Pasteurized Liquid Milk',
      'price': 105, // int
      'qty': 5,
      'image': 'assets/aarong_milk.png',
      'weight': '1 liter',
      'offer': null,
    },
  ];

  String availabilityAction = 'Notify Me';

  // total calculation (int or double handled safely)
  double get total {
    return cartItems.fold<double>(
      0,
      (sum, item) =>
          sum + ((item['price'] as num).toDouble() * (item['qty'] as int)),
    );
  }

  void incrementQty(int index) {
    setState(() {
      cartItems[index]['qty'] = (cartItems[index]['qty'] as int) + 1;
    });
  }

  void decrementQty(int index) {
    setState(() {
      final current = cartItems[index]['qty'] as int;
      if (current > 1) {
        cartItems[index]['qty'] = current - 1;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
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
        title: Row(
          children: [
            Image.asset(
              'assets/cart.png',
              width: 28,
              height: 28,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text(
              'Cart',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
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
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '\$${(item['price'] as num).toDouble().toStringAsFixed(2)} | ${item['weight']}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    if ((item['offer'] as String?) != null)
                                      Text(
                                        item['offer'] as String,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    else
                                      const SizedBox(height: 0),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 36, // slightly smaller than your 40
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
                                            fontSize: 14, // readable font
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
                            content: Text('Navigate to Add More Items screen')),
                      );
                    },
                    child: const Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.add, color: Colors.white, size: 18),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Add More items',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, thickness: 1, color: Colors.black12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'If any product is not available',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: cartItems.isEmpty
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Continuing to checkout... (tak ${total.toStringAsFixed(2)})')),
                      );
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
              )),
          const SizedBox(height: 40)
        ],
      ),
    );
  }
}
