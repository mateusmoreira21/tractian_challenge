import 'package:result_dart/result_dart.dart';
import 'package:tractian_challenge/app/core/exceptions/app_exceptions.dart';
import 'package:tractian_challenge/app/core/exceptions/request_api_exception.dart';
import 'package:tractian_challenge/app/core/services/http_client/http_client.dart';
import 'package:tractian_challenge/app/data/adapters/assets_adapter.dart';
import 'package:tractian_challenge/app/data/adapters/location_adapter.dart';
import 'package:tractian_challenge/app/interaction/models/assets_model.dart';
import 'package:tractian_challenge/app/interaction/models/location_model.dart';
import 'package:tractian_challenge/app/interaction/repositories/assets_repository.dart';

class AssetsRepositoryImpl implements AssetsRepository {
  final HttpClient _client;

  AssetsRepositoryImpl(this._client);

  @override
  AsyncResult<(List<AssetsModel>, List<LocationModel>), AppException> getAssetsByCompany(int companyId) async {
    try {
      final response = await _client.get('/companies/$companyId');
      List<AssetsModel> assets = (response.data['assets'] as List) //
          .map(AssetsAdapter.fromMap)
          .toList();

      List<LocationModel> locations = (response.data['location'] as List) //
          .map(LocationAdapter.fromMap)
          .toList();

      return (assets, locations).toSuccess();
    } on AppException catch (e) {
      return e.message.asRequestException().toFailure();
    }
  }
}
