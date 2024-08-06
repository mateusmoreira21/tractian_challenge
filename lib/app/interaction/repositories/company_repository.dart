import 'package:result_dart/result_dart.dart';
import 'package:tractian_challenge/app/core/exceptions/app_exceptions.dart';
import 'package:tractian_challenge/app/interaction/models/company_model.dart';

abstract class CompanyRepository {
  AsyncResult<List<CompanyModel>, AppException> getCompanies();
}
