import 'package:amar_shoday/features/order/data/order_repository.dart';
import 'package:amar_shoday/features/order/domain/order_model.dart';
import 'package:amar_shoday/features/order/widgets/filter_dialog.dart';
import 'package:amar_shoday/features/order/widgets/order_card.dart';
import 'package:amar_shoday/widgets/bell_icon.dart';
import 'package:amar_shoday/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:amar_shoday/core/constants/colors.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = OrderRepository();
    final activeOrders = repository.getOrders(); // Active orders
    final previousOrders = repository.getPreviousOrders(); // ✅ New method

    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Column(
          children: [
            Container(height: 25, color: Colors.white),
            const TopBarCommon(),
            Container(
              color: Colors.white,
              height: 50,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 110),
                  Text(
                    "Order",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 100),
                  BellIconButton(onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _buildBody(context, activeOrders, previousOrders),
    );
  }

  Widget _buildBody(BuildContext context, List<OrderModel> activeOrders,
      List<OrderModel> previousOrders) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Active Orders
        Text(
          "Active Orders",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.normal,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        ...activeOrders.map((order) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: OrderCard(order: order),
            )),

        const SizedBox(height: 24),

        // Previous Orders with button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Previous Orders",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // allows full height
                  backgroundColor:
                      Colors.transparent, // for rounded corners effect
                  builder: (context) => const FilterBottomSheet(),
                );
              },
              child: Image.asset(
                "assets/config.png",
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),
        ...previousOrders.map((order) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: OrderCard(order: order),
            )),
      ],
    );
  }
}
