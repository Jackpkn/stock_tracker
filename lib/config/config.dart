// it is to load the configuration from .env file
import 'package:dotenv/dotenv.dart';

class Config {
  static String stockApiKey = "";

  static void loadConfig() {
    var env = DotEnv(includePlatformEnvironment: true)..load();
    stockApiKey = env['STOCK_API_KEY'] ?? "";
  }
}
