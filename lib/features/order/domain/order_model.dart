class OrderModel {
  final String id;
  final String image;
  final int items;
  final int price;
  final int queue;
  final String time;

  OrderModel({
    required this.id,
    required this.image,
    required this.items,
    required this.price,
    required this.queue,
    required this.time,
  });
}
