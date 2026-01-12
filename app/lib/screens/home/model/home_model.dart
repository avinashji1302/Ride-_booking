class Order {
  final int id;
  final String customerName;
  final int tableNumber;
  final String status;
  final int price;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.customerName,
    required this.tableNumber,
    required this.status,
    required this.price,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      customerName: json['customer_name'] ?? 'Unknown',
      tableNumber: json['table_number'] ?? 0,
      status: json['status'] ?? 'pending',
      price: json['price'] ?? 0,
      items: (json['items'] as List? ?? [])
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}

class OrderItem {
  final int quantity;
  final String name;

  OrderItem({
    required this.quantity,
    required this.name,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      quantity: json['quantity'] ?? 0,
      name: json['menu']?['name'] ?? 'Item',
    );
  }
}
