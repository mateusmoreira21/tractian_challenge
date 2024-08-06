import 'package:result_dart/result_dart.dart';
import 'package:tractian_challenge/app/core/exceptions/app_exceptions.dart';
import 'package:tractian_challenge/app/interaction/models/location_model.dart';

abstract class LocationRepository {
  AsyncResult<List<LocationModel>, AppException> getLocationsByCompany(int companyId);
}
