import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/app/core/exceptions/request_api_exception.dart';
import 'package:tractian_challenge/app/core/services/http_client/http_client.dart';
import 'package:tractian_challenge/app/core/services/http_client/http_response.dart';
import 'package:tractian_challenge/app/data/repositories/company_repository_impl.dart';
import 'package:tractian_challenge/app/interaction/models/company_model.dart';
import 'package:tractian_challenge/app/interaction/repositories/company_repository.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late final CompanyRepository repository;
  late final HttpClient client;

  setUpAll(() {
    client = HttpClientMock();
    repository = CompanyRepositoryImpl(client);
  });

  group('Get companies', () {
    const String companyTestJson = ''' [{"id": 1, "name": "Apex Unit"},
      {"id": 2, "name": "Jaguar Unit"},
      {"id": 3, "name": "Tobias Unit"}] ''';

    test('return a list of companies when the request is successful ...', () async {
      when(() => client.get(any())).thenAnswer((_) async => HttpResponse(data: jsonDecode(companyTestJson), statusCode: 200));

      final response = await repository.getCompanies();

      expect(response.getOrThrow(), isA<List<CompanyModel>>());
      expect(response.isSuccess(), true);
    });

    test('throws an error when the request fails', () async {
      when(() => client.get(any())).thenThrow(RequestApiException('500 - Internal Server Error'));

      final result = await repository.getCompanies();

      expect(result.isError(), true);
      expect(result.exceptionOrNull()?.message, equals('500 - Internal Server Error'));
    });
  });
}
