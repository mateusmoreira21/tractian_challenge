import 'package:tractian_challenge/app/interaction/models/tree_model.dart';

final class LocationModel extends TreeModel {
  LocationModel({
    required super.id,
    required super.name,
    super.parentId,
  });
}
