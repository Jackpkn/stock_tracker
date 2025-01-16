import 'package:stock_tracker/api/stock_api.dart';
import 'package:stock_tracker/models/stock.dart';

class StockService {
  final StockApi _stockApi;
  StockService({StockApi? stockApi}) : _stockApi = stockApi!;
  Stream<Stock> getStockPriceUpdates(
      String symbol, Duration refreshInterval) async* {
    while (true) {
      try {
        yield await _stockApi.fetchStockData(symbol);
        await Future.delayed(refreshInterval);
      } catch (e) {
        print("An error occurred when retrieving the stock price $e");
        await Future.delayed(refreshInterval); // Continue even on error
      }
    }
  }
}
