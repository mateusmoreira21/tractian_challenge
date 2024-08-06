import 'package:flutter_triple/flutter_triple.dart';
import 'package:result_dart/result_dart.dart';
import 'package:tractian_challenge/app/interaction/models/tree_model.dart';
import 'package:tractian_challenge/app/interaction/repositories/assets_repository.dart';
import 'package:tractian_challenge/app/presenter/states/assets_state.dart';

class AssetsStore extends Store<AssetsState> {
  final AssetsRepository _assetsRepository;

  AssetsStore(this._assetsRepository) : super(StartAssetsState());

  load(int companyId) async {
    await _fetchAssetsByCompany(companyId);

    List<TreeModel> computed = await state.buildTree();

    update(state.computed(computed));
  }

  void resetTree() {
    update(state.resetTrees());
  }

  void filterBySearchText(String text) => update(state.filterTreesBySearch(text));

  void filterBySensors() {
    List<TreeModel> filtered = state.execFilter("energy");
    update(state.filterByEnergySensors(filtered));
  }

  void filterByCriticalAlerts() {
    List<TreeModel> filtered = state.execFilter("alert");
    update(state.filterByEnergySensors(filtered));
  }

  _fetchAssetsByCompany(int companyId) async {
    await _assetsRepository
        .getAssetsByCompany(companyId) //
        .map((success) => state.setAssets(success.$1, success.$2))
        .mapError(state.toError)
        .fold(update, update);
  }
}
