import 'package:stock_tracker/models/stock.dart';

abstract class StockApi {
  Future<Stock> fetchStockData(String symbol);
}
