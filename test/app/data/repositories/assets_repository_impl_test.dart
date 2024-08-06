import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/app/core/exceptions/request_api_exception.dart';
import 'package:tractian_challenge/app/core/services/http_client/http_client.dart';
import 'package:tractian_challenge/app/core/services/http_client/http_response.dart';
import 'package:tractian_challenge/app/data/repositories/assets_repository_impl.dart';
import 'package:tractian_challenge/app/interaction/models/assets_model.dart';
import 'package:tractian_challenge/app/interaction/repositories/assets_repository.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late final AssetsRepository repository;
  late final HttpClient client;

  setUpAll(() {
    client = HttpClientMock();
    repository = AssetsRepositoryImpl(client);
  });

  group('Get assets by company', () {
    const String listAssetsJson = ''' [{
                 "name": "Asset 1",
                 "id": "60fc7c9e95ad84001e95c029",
                 "locationId": "60fc7c9e86cd05001d22b4d5",
                 "parentId": null,
                 "sensorType": null,
                 "status": null
               },
               {
                 "name": "Asset 2",
                 "id": "60fc7c9f07a5ec001e8cfb46",
                 "locationId": "60fc7c9e86cd05001d22b4d5",
                 "parentId": null,
                 "sensorType": null,
                 "status": null
               },
               {
                 "name": "Asset 3",
                 "id": "60fc7c9f57791a201e5751c0",
                 "locationId": "60fc7c9e86cd05001d22b4d5",
                 "parentId": null,
                 "sensorType": null,
                 "status": null
               }] ''';

    test('return a list of assets when the request is successful ...', () async {
      when(() => client.get(any())).thenAnswer((_) async => HttpResponse(data: jsonDecode(listAssetsJson), statusCode: 200));

      final response = await repository.getAssetsByCompany(1);

      expect(response.getOrThrow(), isA<List<AssetsModel>>());
      expect(response.isSuccess(), true);
    });

    test('throws an error when the request fails', () async {
      when(() => client.get(any())).thenThrow(RequestApiException('500 - Internal Server Error'));

      final result = await repository.getAssetsByCompany(1);

      expect(result.isError(), true);
      expect(result.exceptionOrNull()?.message, equals('500 - Internal Server Error'));
    });
  });
}
