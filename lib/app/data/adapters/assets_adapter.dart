import 'package:tractian_challenge/app/interaction/models/assets_model.dart';

class AssetsAdapter {
  AssetsAdapter._();

  static AssetsModel fromMap(dynamic map) {
    return AssetsModel(
      locationId: map['locationId'] ?? '',
      sensorType: map['sensorType'] ?? '',
      status: map['status'] ?? '',
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      parentId: map['parentId'],
      sensorId: map['sensorId'] ?? '',
      gatewayId: map['gatewayId'] ?? '',
    );
  }
}
