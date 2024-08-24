
class InvoiceModel{
  final String customer;
  final String address;
  final String transactionId;
  final List<OrderItem> items;
  InvoiceModel(this.customer, this.address, this.items, this.transactionId);

   double totalCost() {
    return items.fold(
        0, (previousValue, element) => previousValue + element.price!);
  }
}

class OrderItem {
  String orderId;
  int productId;
  String? productName;
  int quantity;
  double? total;
  double? price;
  OrderItem({
    required this.orderId,
    required this.productId,
    required this.quantity,
    this.productName,
    this.total,
    this.price,
  });
}
