class DailyResulCharttModel {
  final String date;
  final String months;
  final String wins;
  final String losses;
  final String dProfit;
  final String atProfit;
  DailyResulCharttModel({
    required this.date,
    required this.months,
    required this.wins,
    required this.losses,
    required this.dProfit,
    required this.atProfit,
  });
}

List<DailyResulCharttModel> dailyResulList = [
  DailyResulCharttModel(
    date: '22',
    months: 'july',
    wins: '8',
    losses: '6',
    dProfit: '0.75',
    atProfit: '0.75',
  ),
  DailyResulCharttModel(
    date: '23',
    months: 'july',
    wins: '9',
    losses: '10',
    dProfit: '-1.59',
    atProfit: '-0.84',
  ),
  DailyResulCharttModel(
    date: '24',
    months: 'july',
    wins: '3',
    losses: '8',
    dProfit: '-5.36',
    atProfit: '-6.2',
  ),
  DailyResulCharttModel(
    date: '25',
    months: 'july',
    wins: '3',
    losses: '5',
    dProfit: '-4.45',
    atProfit: '-10.65',
  ),
  DailyResulCharttModel(
    date: '26',
    months: 'july',
    wins: '8',
    losses: '10',
    dProfit: '-3.5',
    atProfit: '-10.65',
  ),
  DailyResulCharttModel(
    date: '27',
    months: 'july',
    wins: '7',
    losses: '3',
    dProfit: '0.75',
    atProfit: '0.75',
  ),
  DailyResulCharttModel(
    date: '28',
    months: 'july',
    wins: '5',
    losses: '9',
    dProfit: '0.75',
    atProfit: '0.75',
  ),
  DailyResulCharttModel(
    date: '29',
    months: 'july',
    wins: '4',
    losses: '6',
    dProfit: '0.75',
    atProfit: '0.75',
  ),
  DailyResulCharttModel(
    date: '30',
    months: 'july',
    wins: '12',
    losses: '8',
    dProfit: '0.75',
    atProfit: '0.75',
  ),
];

class PreviousData {
  final String amount;
  final String totalText;

  PreviousData({
    required this.amount,
    required this.totalText,
  });
}

List<PreviousData> previousDataList = [
  PreviousData(amount: 'Total', totalText: '0'),
  PreviousData(amount: 'yesterday', totalText: '0.45'),
  PreviousData(amount: 'last 7 days', totalText: '4.1'),
  PreviousData(amount: 'last 30 days', totalText: '16.81'),
  PreviousData(amount: 'all time', totalText: '26.53'),
];
