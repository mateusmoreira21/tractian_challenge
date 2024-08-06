import 'package:tractian_challenge/app/interaction/models/tree_model.dart';

final class AssetsModel extends TreeModel {
  AssetsModel({
    required this.sensorType,
    required this.status,
    required this.gatewayId,
    required this.sensorId,
    required super.id,
    required super.name,
    super.parentId,
    super.locationId,
  });

  final String sensorType;
  final String status;
  final String gatewayId;
  final String sensorId;
}
