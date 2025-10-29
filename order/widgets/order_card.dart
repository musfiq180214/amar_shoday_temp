import 'package:amar_shoday/core/constants/colors.dart';
import 'package:amar_shoday/features/order/domain/order_model.dart';
import 'package:amar_shoday/core/routes/route_names.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🖼️ Image
          CircleAvatar(
            radius: 23,
            backgroundColor: AppColors.buttonColor,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(order.image ?? "none"),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 📄 Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1
                Row(
                  children: [
                    const Text(
                      "ID: ",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      order.id,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(width: 60),
                    Row(
                      children: [
                        if (order.queue != null) ...[
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: AppColors.secondaryColor,
                          ),
                          const SizedBox(width: 4),
                        ],
                        Text(order.time,
                            style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 6),
                const Divider(color: Colors.grey, thickness: 1),

                // Row 2
                Row(
                  children: [
                    const Text("Items No. ",
                        style: TextStyle(color: Colors.black)),
                    Text("${order.items}",
                        style: const TextStyle(color: Colors.black)),
                    const SizedBox(width: 115),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "৳ ${order.price}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),

                const Divider(color: Colors.grey, thickness: 1),

                // Row 3
                Row(
                  children: [
                    if (order.queue != null) ...[
                      const Text(
                        "Queue No.",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 4),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: AppColors.primaryColor,
                        child: Text(
                          "${order.queue}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 55),
                    ] else
                      const Spacer(),

                    // ✅ Make View Details tappable
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.orderDetails,
                          arguments: {'orderId': order.id},
                        );
                      },
                      child: Text(
                        "View Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green.shade700,
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
