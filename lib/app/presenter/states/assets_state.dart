import 'package:tractian_challenge/app/core/exceptions/app_exceptions.dart';
import 'package:tractian_challenge/app/interaction/models/assets_model.dart';
import 'package:tractian_challenge/app/interaction/models/location_model.dart';
import 'package:tractian_challenge/app/interaction/models/tree_model.dart';

sealed class AssetsState {
  AssetsState({required this.assets, required this.locations, required this.trees, required this.treesFiltered});

  final List<AssetsModel> assets;
  final List<LocationModel> locations;
  final List<TreeModel> trees;
  final List<TreeModel> treesFiltered;

  AssetsState setAssets(List<AssetsModel> gettedAssets) => LoadedAssetsState(
        assets: gettedAssets,
        locations: locations,
        trees: trees,
        treesFiltered: treesFiltered,
      );

  AssetsState setLocations(List<LocationModel> gettedLocations) => LoadedAssetsState(
        assets: assets,
        locations: gettedLocations,
        trees: trees,
        treesFiltered: treesFiltered,
      );

  AssetsState computed() => LoadedAssetsState(
        assets: assets,
        locations: locations,
        trees: buildTree(),
        treesFiltered: buildTree(),
      );

  AssetsState toError(AppException error) => ErrorAssetsState(error.message);

  AssetsState filterTreesBySearch(String filter) {
    return LoadedAssetsState(
      assets: assets,
      locations: locations,
      trees: trees,
      treesFiltered: filter == "" ? trees : execFilter(filter),
    );
  }

  AssetsState filterByEnergySensors() {
    return LoadedAssetsState(
      assets: assets,
      locations: locations,
      trees: execFilter("energy"),
      treesFiltered: execFilter("energy"),
    );
  }

  AssetsState filterByCriticalAlert() => LoadedAssetsState(
        assets: assets,
        locations: locations,
        trees: execFilter("alert"),
        treesFiltered: execFilter("alert"),
      );

  AssetsState resetTrees() {
    return LoadedAssetsState(
      assets: assets,
      locations: locations,
      trees: trees,
      treesFiltered: buildTree(),
    );
  }

  //
  List<TreeModel> get _computedTrees {
    return [...locations, ...assets];
  }

  List<TreeModel> buildTree() {
    final List<TreeModel> rootItems = [];

    for (var item in _computedTrees) {
      item.children.clear();
      item.children.addAll(getParents(item));

      if (item.parentId == null && item.locationId == null || !_computedTrees.any((element) => item.parentId == element.id || item.locationId == element.id)) {
        rootItems.add(item);
      }
    }

    return rootItems;
  }

  List<TreeModel> execFilter(String filter) {
    List<TreeModel> filtered = [];

    for (var element in buildTree()) {
      _filterTreeListForAlert(filtered, element, filter);
    }

    return filtered;
  }

  void _filterTreeListForAlert(List<TreeModel> result, TreeModel node, String valueFilter) {
    if (node.filter(valueFilter)) {
      var filteredNode = node.createInstance();
      for (var child in node.children) {
        var filteredChild = child.filterTreeForAlert(valueFilter);
        if (filteredChild != null) {
          filteredNode.children.add(filteredChild);
        }
      }
      result.add(filteredNode);
    }
  }

  List<TreeModel> getParents(TreeModel model) {
    return _computedTrees.where((e) => e.parentId == model.id || e.locationId == model.id).toList();
  }
}

final class StartAssetsState extends AssetsState {
  StartAssetsState() : super(assets: [], locations: [], trees: [], treesFiltered: []);
}

final class LoadedAssetsState extends AssetsState {
  LoadedAssetsState({required super.assets, required super.locations, required super.trees, required super.treesFiltered});
}

final class ErrorAssetsState extends AssetsState {
  final String message;
  ErrorAssetsState(this.message) : super(assets: [], locations: [], trees: [], treesFiltered: []);
}
