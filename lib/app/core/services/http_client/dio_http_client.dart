import 'package:dio/dio.dart';
import 'package:tractian_challenge/app/core/constants/constants.dart';
import 'package:tractian_challenge/app/core/exceptions/request_api_exception.dart';
import 'package:tractian_challenge/app/core/services/http_client/http_client.dart';
import 'package:tractian_challenge/app/core/services/http_client/http_response.dart';

class DioHttpClient implements HttpClient {
  late final Dio client;

  DioHttpClient() {
    client = Dio(
      BaseOptions(
        baseUrl: baseUrlDB,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  @override
  Future<HttpResponse> get(String path) async {
    try {
      final result = await client.get(path);
      return HttpResponse(
        statusCode: result.statusCode,
        data: result.data,
      );
    } on DioException catch (e, s) {
      throw RequestApiException(e.message ?? "Erro não tratado", s);
    }
  }
}
