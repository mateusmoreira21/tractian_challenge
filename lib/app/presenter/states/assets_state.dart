import 'package:tractian_challenge/app/core/exceptions/app_exceptions.dart';
import 'package:tractian_challenge/app/interaction/models/assets_model.dart';
import 'package:tractian_challenge/app/interaction/models/location_model.dart';
import 'package:tractian_challenge/app/interaction/models/tree_model.dart';

sealed class AssetsState {
  AssetsState({required this.assets, required this.locations, required this.buildedTree, required this.treesFiltered, required this.originalBuilder});

  final List<AssetsModel> assets;
  final List<LocationModel> locations;
  final List<TreeModel> originalBuilder;
  final List<TreeModel> buildedTree;
  final List<TreeModel> treesFiltered;

  AssetsState setAssets(List<AssetsModel> gettedAssets, List<LocationModel> gettedLocations) => LoadedAssetsState(
        assets: gettedAssets,
        locations: gettedLocations,
        buildedTree: buildedTree,
        treesFiltered: treesFiltered,
        originalBuilder: originalBuilder,
      );

  AssetsState computed(List<TreeModel> computedTree) => LoadedAssetsState(
        assets: assets,
        locations: locations,
        buildedTree: computedTree,
        treesFiltered: computedTree,
        originalBuilder: computedTree,
      );

  AssetsState toError(AppException error) => ErrorAssetsState(error.message);

  AssetsState filterTreesBySearch(String filter) {
    return LoadedAssetsState(
      assets: assets,
      locations: locations,
      buildedTree: buildedTree,
      treesFiltered: filter == "" ? buildedTree : execFilter(filter),
      originalBuilder: originalBuilder,
    );
  }

  AssetsState filterByEnergySensors(List<TreeModel> filtered) {
    return LoadedAssetsState(
      assets: assets,
      locations: locations,
      buildedTree: filtered,
      treesFiltered: filtered,
      originalBuilder: originalBuilder,
    );
  }

  // AssetsState filterByCriticalAlert() => LoadedAssetsState(
  //       assets: assets,
  //       locations: locations,
  //       buildedTree: buildedTree,
  //       treesFiltered: execFilter("alert"),
  //     );

  AssetsState resetTrees() {
    return LoadedAssetsState(
      assets: assets,
      locations: locations,
      buildedTree: originalBuilder,
      treesFiltered: originalBuilder,
      originalBuilder: originalBuilder,
    );
  }

  //
  List<TreeModel> get _computedTrees {
    return [...locations, ...assets];
  }

  Future<List<TreeModel>> buildTree() async {
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

    for (var element in originalBuilder) {
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
  StartAssetsState() : super(assets: [], locations: [], buildedTree: [], treesFiltered: [], originalBuilder: []);
}

final class LoadedAssetsState extends AssetsState {
  LoadedAssetsState({required super.assets, required super.locations, required super.buildedTree, required super.treesFiltered, required super.originalBuilder});
}

final class ErrorAssetsState extends AssetsState {
  final String message;
  ErrorAssetsState(this.message) : super(assets: [], locations: [], buildedTree: [], treesFiltered: [], originalBuilder: []);
}
