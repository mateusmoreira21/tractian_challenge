import 'package:result_dart/result_dart.dart';
import 'package:tractian_challenge/app/core/exceptions/app_exceptions.dart';
import 'package:tractian_challenge/app/core/exceptions/request_api_exception.dart';
import 'package:tractian_challenge/app/core/services/http_client/http_client.dart';
import 'package:tractian_challenge/app/data/adapters/location_adapter.dart';
import 'package:tractian_challenge/app/interaction/models/location_model.dart';
import 'package:tractian_challenge/app/interaction/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final HttpClient _client;

  LocationRepositoryImpl(this._client);

  @override
  AsyncResult<List<LocationModel>, AppException> getLocationsByCompany(int companyId) async {
    try {
      final response = await _client.get('/companies/$companyId');
      List<LocationModel> locations = (response.data['location'] as List) //
          .map(LocationAdapter.fromMap)
          .toList();

      return locations.toSuccess();
    } on AppException catch (e) {
      return e.message.asRequestException().toFailure();
    }
  }
}
