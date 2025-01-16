// lib/api/stock_api_impl.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_tracker/errors/error.dart';

import '../config/config.dart';
import '../models/stock.dart';
import 'stock_api.dart';

class StockApiImpl implements StockApi {
  final http.Client _httpClient;

  StockApiImpl({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<Stock> fetchStockData(String symbol) async {
    final apiKey = Config.stockApiKey;
    final url = Uri.parse(
        'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey');
    try {
      final response = await _httpClient.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        if (jsonResponse.containsKey("Global Quote")) {
          return Stock.fromJson(jsonResponse["Global Quote"]);
        } else {
          throw InvalidApiResponseException("Invalid response from API");
        }
      } else if (response.statusCode == 401) {
        throw UnauthorizedApiException(
            "Invalid API key, please check your .env file");
      } else if (response.statusCode == 400) {
        throw BadRequestApiException(
            "Check the stock symbol you are using. Is '$symbol' correct?");
      } else if (response.statusCode == 429) {
        throw TooManyRequestsApiException("Too many requests to the API");
      } else {
        throw ApiException(
            "Error with API call. Status code: ${response.statusCode}");
      }
    } on http.ClientException {
      throw NetworkException(
          "There was a network error when making the API call");
    } catch (e) {
      rethrow;
    }
  }
}
