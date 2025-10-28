import 'package:amar_shoday/features/order/domain/order_model.dart';

class OrderRepository {
  // Sample orders
  List<OrderModel> getOrders() {
    return [
      OrderModel(
        id: "024586",
        image: "assets/images/order1.png",
        items: 6,
        price: 999,
        queue: 5,
        time: "15 min needed",
      ),
      OrderModel(
        id: "024587",
        image: "assets/images/order2.png",
        items: 3,
        price: 499,
        queue: 2,
        time: "10 min needed",
      ),
    ];
  }
}
