import 'package:tractian_challenge/app/core/services/http_client/http_response.dart';

abstract class HttpClient {
  Future<HttpResponse> get(String path);
}
