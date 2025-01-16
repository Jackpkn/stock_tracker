import 'package:stock_tracker/models/stock.dart';

class NotificationService {
  double _highLimit = 0;
  double _lowLimit = 0;

  void setHighLimit(double limit) {
    _highLimit = limit;
  }

  void setLowLimit(double limit) {
    _lowLimit = limit;
  }

  Stream<Stock> monitorPriceChanges(Stream<Stock> stockStream) async* {
    await for (final stock in stockStream) {
      if (_highLimit != 0 && stock.price > _highLimit) {
        print(
            "ALERT: Stock ${stock.symbol} price is above high limit (${stock.price})");
      }
      if (_lowLimit != 0 && stock.price < _lowLimit) {
        print(
            "ALERT: Stock ${stock.symbol} price is below low limit (${stock.price})");
      }
      print(
          "Stock Price: ${stock.symbol}: ${stock.price}, Change: ${stock.change} (${stock.changePercent}%)");
      yield stock;
    }
  }
}
