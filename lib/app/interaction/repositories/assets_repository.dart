import 'package:result_dart/result_dart.dart';
import 'package:tractian_challenge/app/core/exceptions/app_exceptions.dart';
import 'package:tractian_challenge/app/interaction/models/assets_model.dart';

abstract class AssetsRepository {
  AsyncResult<List<AssetsModel>, AppException> getAssetsByCompany(int companyId);
}
