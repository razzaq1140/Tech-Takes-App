class ActiveCoupenModel {
  final String sidePercent;
  final String headText;
  final String bottomText;
  final String startDate;
  final String lastDate;
  final String circlePercent;

  ActiveCoupenModel({
    required this.sidePercent,
    required this.headText,
    required this.bottomText,
    required this.startDate,
    required this.lastDate,
    required this.circlePercent,
  });
}

List<ActiveCoupenModel> activeCouponList = [
  ActiveCoupenModel(
    sidePercent: "10",
    headText: "The New",
    bottomText: "This coupon Contain 10% Discount",
    startDate: "10-20-24",
    lastDate: "11-25-24",
    circlePercent: "10",
  ),
  ActiveCoupenModel(
    sidePercent: "10",
    headText: "The Promotion's",
    bottomText: "This coupon Contain 10% Discount",
    startDate: "10-20-24",
    lastDate: "11-25-24",
    circlePercent: "10",
  ),
  ActiveCoupenModel(
    sidePercent: "10",
    headText: "The New",
    bottomText: "This coupon Contain 10% Discount",
    startDate: "10-20-24",
    lastDate: "11-25-24",
    circlePercent: "10",
  ),
];
