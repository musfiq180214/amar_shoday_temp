import 'package:amar_shoday/core/constants/colors.dart';
import 'package:amar_shoday/widgets/bell_icon.dart';
import 'package:flutter/material.dart';
import 'package:amar_shoday/widgets/top_bar.dart';

class OrderDetailsPage extends StatelessWidget {
  final String orderId;
  const OrderDetailsPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ white background
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
                  const SizedBox(width: 80),
                  Text(
                    "Order Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor, // ✅ all text black
                    ),
                  ),
                  const Spacer(),
                  BellIconButton(onPressed: () {}),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.white, // ✅ white card background
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 180,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors
                          .primaryColor, // optional: keep primary color if needed
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Order ID: $orderId",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Status and Date
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "25 Feb 2025",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Customer and Time
                  const Row(
                    children: [
                      Icon(Icons.person, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Mohammad Rasel",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Spacer(),
                      Text(
                        "10.15 am",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Stores
                  StoreDetail(
                    storeName: "Bismillah Store",
                    items: [
                      StoreItem(
                        name: "Soyabin Oil",
                        brand: "Fresh",
                        unit: "5 Liter",
                        price: 800,
                        quantity: 1,
                      ),
                      StoreItem(
                        name: "Tea Pack",
                        brand: "Ispahani Mirzapur PD Tea New Super Ultra",
                        unit: "500 gm",
                        price: 225,
                        quantity: 1,
                      ),
                    ],
                    discountPercent: 10,
                  ),
                  const SizedBox(height: 16),
                  StoreDetail(
                    storeName: "Rahim Store",
                    items: [
                      StoreItem(
                        name: "Sugar",
                        brand: "Deshi",
                        unit: "1 Kg",
                        price: 500,
                        quantity: 1,
                      ),
                      StoreItem(
                        name: "Rice",
                        brand: "Miniket",
                        unit: "2 Kg",
                        price: 400,
                        quantity: 1,
                      ),
                      StoreItem(
                        name: "Beverage",
                        brand: "Coca Cola",
                        unit: "1 Liter",
                        price: 400,
                        quantity: 1,
                      ),
                    ],
                    discountPercent: 5,
                  ),
                  const SizedBox(height: 16),
                  const SummaryRow(
                      title: "Total Price",
                      subtitle: "excluding discount",
                      amount: 2950),
                  const Divider(thickness: 1),
                  const SummaryRow(title: "Discount Amount", amount: 200),
                  const Divider(thickness: 1),
                  const SummaryRow(
                      title: "Delivery Charge",
                      subtitle: "more than one store",
                      amount: 50),
                  const Divider(thickness: 1),
                  const SummaryRow(
                      title: "Grand Total", amount: 2800, isBold: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ========================
/// Store Detail Section
/// ========================

class StoreDetail extends StatelessWidget {
  final String storeName;
  final List<StoreItem> items;
  final double discountPercent;

  const StoreDetail({
    super.key,
    required this.storeName,
    required this.items,
    required this.discountPercent,
  });

  @override
  Widget build(BuildContext context) {
    double totalAmount =
        items.fold(0, (sum, item) => sum + (item.price * item.quantity));

    return Card(
      color: Colors.amber[100], // ✅ white background
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store title + review button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Image.asset(
                    "assets/store.png",
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {},
                ),
                Text(
                  storeName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // ✅ forced black
                  ),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey[200],
                  child: IconButton(
                    icon: Image.asset(
                      "assets/green_favourite.png",
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {},
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Review",
                    style: TextStyle(
                      color: Colors.black, // ✅ forced black
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                      decorationThickness: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Header row
            LayoutBuilder(
              builder: (context, constraints) {
                double columnWidth = constraints.maxWidth / 10;
                double baseFontSize = columnWidth < 60 ? 10 : 13;

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // ✅ white background
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Items",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: baseFontSize,
                            color: Colors.black, // ✅ black
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Unit Price",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: baseFontSize,
                            color: Colors.black, // ✅ black
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Quantity",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: baseFontSize,
                            color: Colors.black, // ✅ black
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Total",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: baseFontSize,
                            color: Colors.black, // ✅ black
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 6),

            // Items List
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black, // ✅ black
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "${item.brand} | ${item.unit}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black, // ✅ black
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "৳ ${item.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black, // ✅ black
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Center(
                          child: Text(
                            "${item.quantity}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black, // ✅ black
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "৳  ${(item.price * item.quantity).toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black, // ✅ black
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Divider(thickness: 1, height: 18, color: Colors.black54),

            // Discount row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Discount ($discountPercent%)",
                  style: const TextStyle(fontSize: 13, color: Colors.black),
                ),
                Text(
                  "৳  ${(totalAmount * discountPercent / 100).toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 13, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Subtotal row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Sub Total",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black),
                ),
                Text(
                  "৳  ${(totalAmount - (totalAmount * discountPercent / 100)).toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ========================
/// Store Item Model
/// ========================
class StoreItem {
  final String name;
  final String brand;
  final String unit;
  final double price;
  final int quantity;

  StoreItem({
    required this.name,
    required this.brand,
    required this.unit,
    required this.price,
    required this.quantity,
  });
}

/// ========================
/// Summary Row Widget
/// ========================
class SummaryRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double amount;
  final bool isBold;

  const SummaryRow({
    super.key,
    required this.title,
    required this.amount,
    this.subtitle,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: Colors.black, // ✅ black
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textStyle,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    "(${subtitle!})",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              "৳ $amount",
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
