import 'package:tractian_challenge/app/core/exceptions/app_exceptions.dart';
import 'package:tractian_challenge/app/interaction/models/company_model.dart';

sealed class CompanyState {
  final List<CompanyModel> companies;

  CompanyState(this.companies);

  CompanyState toLoaded(List<CompanyModel> companies) => LoadedCompanyState(companies);
  CompanyState toError(AppException error) => ErrorCompanyState(error.message);
}

final class StartCompanyState extends CompanyState {
  StartCompanyState() : super(const []);
}

final class LoadedCompanyState extends CompanyState {
  LoadedCompanyState(super.companies);
}

final class ErrorCompanyState extends CompanyState {
  final String message;
  ErrorCompanyState(this.message) : super(const []);
}
