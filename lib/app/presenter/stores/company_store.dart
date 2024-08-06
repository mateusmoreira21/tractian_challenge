import 'package:flutter_triple/flutter_triple.dart';
import 'package:result_dart/result_dart.dart';
import 'package:tractian_challenge/app/interaction/repositories/company_repository.dart';
import 'package:tractian_challenge/app/presenter/states/company_state.dart';

class CompanyStore extends Store<CompanyState> {
  CompanyStore(this._companyRepository) : super(StartCompanyState());

  final CompanyRepository _companyRepository;

  getAllCompanies() async {
    await _companyRepository
        .getCompanies() //
        .map(state.toLoaded)
        .mapError(state.toError)
        .fold(update, update);
  }
}
