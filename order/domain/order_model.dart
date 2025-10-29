class OrderModel {
  final String id;
  final int items;
  final int price;
  final int? queue; // ✅ nullable for previous orders
  final String time;
  final String? image; // ✅ new optional image field

  OrderModel({
    required this.id,
    required this.items,
    required this.price,
    this.queue,
    required this.time,
    this.image, // ✅ optional image
  });
}
