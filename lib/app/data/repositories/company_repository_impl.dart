import 'package:result_dart/result_dart.dart';
import 'package:tractian_challenge/app/core/exceptions/app_exceptions.dart';
import 'package:tractian_challenge/app/core/exceptions/request_api_exception.dart';
import 'package:tractian_challenge/app/core/services/http_client/http_client.dart';
import 'package:tractian_challenge/app/data/adapters/company_adapter.dart';
import 'package:tractian_challenge/app/interaction/models/company_model.dart';
import 'package:tractian_challenge/app/interaction/repositories/company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final HttpClient _client;

  CompanyRepositoryImpl(this._client);

  @override
  AsyncResult<List<CompanyModel>, AppException> getCompanies() async {
    try {
      final response = await _client.get('/companies');
      List<CompanyModel> companies = (response.data as List) //
          .map(CompanyAdapter.fromMap)
          .toList();

      return companies.toSuccess();
    } on AppException catch (e) {
      return e.message.asRequestException().toFailure();
    }
  }
}
