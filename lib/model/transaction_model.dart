class TransactionModel {
  final String orderId;
  final String productId;
  final int quantity;
  final double pricePerProduct;
  final double totalPrice;
  final String paymentMethod;
  final DateTime transactionDate;

  TransactionModel({
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.pricePerProduct,
    required this.totalPrice,
    required this.paymentMethod,
    required this.transactionDate,
  });
}
