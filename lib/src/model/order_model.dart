class OrderDetails {
  final String cardNumber;
  final String cardType;
  final String expirationDate;
  final double totalCost;
  final double shippingCost;
  final double discount;
  final double orderTotal;

  OrderDetails({
    required this.cardNumber,
    required this.cardType,
    required this.expirationDate,
    required this.totalCost,
    required this.shippingCost,
    required this.discount,
    required this.orderTotal,
  });
}
