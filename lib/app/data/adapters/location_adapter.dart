import 'package:tractian_challenge/app/interaction/models/location_model.dart';

class LocationAdapter {
  LocationAdapter._();

  static LocationModel fromMap(dynamic map) {
    return LocationModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      parentId: map['parentId'],
    );
  }
}
