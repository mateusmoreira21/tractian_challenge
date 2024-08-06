import 'package:tractian_challenge/app/interaction/models/company_model.dart';

class CompanyAdapter {
  CompanyAdapter._();

  static CompanyModel fromMap(dynamic map) {
    return CompanyModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
