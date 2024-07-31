import 'package:conversor_de_moeda/models/conversion.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConversionRepository {
  final String apiKey = dotenv.env['API_KEY'] ?? '';
  final Dio _dio = Dio();

  Future<Conversion> fetchConversionRate(String from, String to) async {
    final url = 'https://v6.exchangerate-api.com/v6/$apiKey/latest/$from';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        final conversionRate = jsonResponse['conversion_rates'][to];
        
        return conversionRate;
      } else {
        throw Exception('Failed to fetch conversion rate');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            'Failed to fetch conversion rate: ${e.response?.statusCode}');
      } else {
        throw Exception('Failed to fetch conversion rate: ${e.message}');
      }
    }
  }
}
