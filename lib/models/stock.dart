// lib/models/stock.dart

class Stock {
  final String symbol;
  final double price;
  final double change;
  final double changePercent;

  Stock({
    required this.symbol,
    required this.price,
    required this.change,
    required this.changePercent,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    // if (json == null) {
    //   throw InvalidApiResponseException("API response was null");
    // }

    return Stock(
      symbol: json['01. symbol'] ?? "",
      price: double.parse(json['05. price'] ?? '0'),
      change: double.parse(json['09. change'] ?? '0'),
      changePercent:
          double.parse((json['10. change percent'] ?? '0').replaceAll("%", "")),
    );
  }
}
