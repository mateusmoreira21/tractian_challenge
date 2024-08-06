// import 'dart:convert';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:tractian_challenge/app/core/exceptions/request_api_exception.dart';
// import 'package:tractian_challenge/app/core/services/http_client/http_client.dart';
// import 'package:tractian_challenge/app/core/services/http_client/http_response.dart';
// import 'package:tractian_challenge/app/data/repositories/location_repository_impl.dart';
// import 'package:tractian_challenge/app/interaction/models/location_model.dart';
// import 'package:tractian_challenge/app/interaction/repositories/location_repository.dart';

// class HttpClientMock extends Mock implements HttpClient {}

// void main() {
//   late final LocationRepository repository;
//   late final HttpClient client;

//   setUpAll(() {
//     client = HttpClientMock();
//     repository = LocationRepositoryImpl(client);
//   });

//   group('Get locations by company', () {
//     const String locationTestJson = ''' [
//                {
//                  "name": "CHARCOAL STORAGE SECTOR",
//                  "id": "656a07b3f2d4a1001e2144bf",
//                  "parentId": "65674204664c41001e91ecb4"
//                },
//                {
//                  "name": "Empty Machine house",
//                  "id": "656733611f4664001f295dd0",
//                  "parentId": null
//                },
//                {
//                  "name": "Machinery house",
//                  "id": "656733b1664c41001e91d9ed",
//                  "parentId": null
//                }] ''';

//     test('return a list of locations when the request is successful ...', () async {
//       when(() => client.get(any())).thenAnswer((_) async => HttpResponse(data: jsonDecode(locationTestJson), statusCode: 200));

//       final response = await repository.getLocationsByCompany(1);

//       expect(response.getOrThrow(), isA<List<LocationModel>>());
//       expect(response.isSuccess(), true);
//     });

//     test('throws an error when the request fails', () async {
//       when(() => client.get(any())).thenThrow(RequestApiException('500 - Internal Server Error'));

//       final result = await repository.getLocationsByCompany(1);

//       expect(result.isError(), true);
//       expect(result.exceptionOrNull()?.message, equals('500 - Internal Server Error'));
//     });
//   });
// }
