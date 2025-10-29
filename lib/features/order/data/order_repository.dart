import 'package:amar_shoday/features/order/domain/order_model.dart';

class OrderRepository {
  // 🟢 Active Orders
  List<OrderModel> getOrders() {
    return [
      OrderModel(
        id: "024586",
        items: 6,
        price: 999,
        queue: 1,
        time: "15 min needed",
        image: "assets/order1.png",
      ),
      OrderModel(
        id: "024587",
        items: 3,
        price: 499,
        queue: 2,
        time: "10 min needed",
        image: "assets/order1.png",
      ),
    ];
  }

  // 🟡 Previous Orders (no queue, different images)
  List<OrderModel> getPreviousOrders() {
    return [
      OrderModel(
        id: "024570",
        items: 4,
        price: 799,
        time: "25 Feb, 2025",
        image: "assets/order2.png",
      ),
      OrderModel(
        id: "024568",
        items: 2,
        price: 299,
        time: "22 Feb, 2025",
        image: "assets/order3.png",
      ),
      OrderModel(
        id: "024568",
        items: 2,
        price: 299,
        time: "22 Feb, 2025",
        image: "assets/order4.png",
      ),
      OrderModel(
        id: "024568",
        items: 2,
        price: 299,
        time: "22 Feb, 2025",
        image: "assets/order5.png",
      ),
    ];
  }
}
