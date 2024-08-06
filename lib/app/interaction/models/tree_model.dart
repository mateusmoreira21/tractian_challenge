import 'package:tractian_challenge/app/interaction/models/assets_model.dart';
import 'package:tractian_challenge/app/interaction/models/location_model.dart';

base class TreeModel {
  TreeModel({
    required this.id,
    required this.name,
    this.parentId,
    this.locationId,
  });

  String id;
  String name;
  String? parentId;
  String? locationId;
  List<TreeModel> children = [];

  bool filter(String value) {
    if (this is AssetsModel) {
      final asset = this as AssetsModel;
      if (asset.status == value || asset.sensorType == value || asset.name.toLowerCase().contains(value)) {
        return true;
      }
    } else if (this is LocationModel) {
      final location = this as LocationModel;
      if (location.name.toLowerCase().contains(value)) {
        return true;
      }
    }
    for (var child in children) {
      if (child.filter(value)) {
        return true;
      }
    }
    return false;
  }

  TreeModel? filterTreeForAlert(String value) {
    if (filter(value)) {
      var filteredTree = createInstance();
      for (var child in children) {
        var filteredChild = child.filterTreeForAlert(value);
        if (filteredChild != null) {
          filteredTree.children.add(filteredChild);
        }
      }
      return filteredTree;
    }
    return null;
  }

  TreeModel createInstance() {
    if (this is LocationModel) {
      return LocationModel(
        id: id,
        name: name,
        parentId: parentId,
      );
    } else if (this is AssetsModel) {
      final asset = this as AssetsModel;
      return AssetsModel(
        sensorType: asset.sensorType,
        status: asset.status,
        gatewayId: asset.gatewayId,
        sensorId: asset.sensorId,
        id: id,
        name: name,
        parentId: parentId,
        locationId: locationId,
      );
    } else {
      throw Exception('Unsupported TreeModel type');
    }
  }
}
