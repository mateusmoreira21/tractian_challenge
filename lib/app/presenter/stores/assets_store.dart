import 'package:flutter_triple/flutter_triple.dart';
import 'package:result_dart/result_dart.dart';
import 'package:tractian_challenge/app/interaction/repositories/assets_repository.dart';
import 'package:tractian_challenge/app/interaction/repositories/location_repository.dart';
import 'package:tractian_challenge/app/presenter/states/assets_state.dart';

class AssetsStore extends Store<AssetsState> {
  final AssetsRepository _assetsRepository;
  final LocationRepository _locationRepository;

  AssetsStore(this._assetsRepository, this._locationRepository) : super(StartAssetsState());

  load(int companyId) async {
    await _fetchLocationByCompany(companyId);

    await _fetchAssetsByCompany(companyId);

    update(state.computed());
  }

  void resetTree() => update(state.resetTrees());

  void filterBySearchText(String text) => update(state.filterTreesBySearch(text));

  void filterBySensors() => update(state.filterByEnergySensors());

  void filterByCriticalAlerts() => update(state.filterByCriticalAlert());

  _fetchAssetsByCompany(int companyId) async {
    await _assetsRepository
        .getAssetsByCompany(companyId) //
        .map((assets) => state.setAssets(assets))
        .mapError(state.toError)
        .fold(update, update);
  }

  _fetchLocationByCompany(int companyId) async {
    await _locationRepository
        .getLocationsByCompany(companyId) //
        .map((locations) => state.setLocations(locations))
        .mapError(state.toError)
        .fold(update, update);
  }
}
