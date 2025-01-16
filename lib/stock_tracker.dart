import 'package:stock_tracker/api/stock_api_impl.dart';
import 'package:stock_tracker/config/config.dart';
import 'package:stock_tracker/services/notification_service.dart';
import 'package:stock_tracker/services/stock_service.dart';
import 'package:stock_tracker/utils/helpers.dart';

main(List<String> arguments) async {
  Config.loadConfig();
  final args = Helpers.parseArgument(arguments);
  final symbol = args['symbol'] ?? 'IBM';
  final refreshInterval = Duration(seconds: int.parse(args['refresh'] ?? '5'));
  final highLimit = double.parse(args['highLimit'] ?? '0');
  final lowLimit = double.parse(args['lowLimit'] ?? '0');

  final stockApi = StockApiImpl();
  final stockService = StockService(stockApi: stockApi);
  final notificationService = NotificationService();

  notificationService.setHighLimit(highLimit);
  notificationService.setLowLimit(lowLimit);

  final stream = stockService.getStockPriceUpdates(symbol, refreshInterval);
  notificationService.monitorPriceChanges(stream).listen((stock) {},
      onError: (error) {
    print("Error found on stream $error");
  }, onDone: () {
    print("Process finished");
  });
}
