import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_challenge/app/core/services/http_client/dio_http_client.dart';
import 'package:tractian_challenge/app/core/services/http_client/http_client.dart';
import 'package:tractian_challenge/app/data/repositories/assets_repository_impl.dart';
import 'package:tractian_challenge/app/data/repositories/company_repository_impl.dart';
import 'package:tractian_challenge/app/interaction/repositories/assets_repository.dart';
import 'package:tractian_challenge/app/interaction/repositories/company_repository.dart';
import 'package:tractian_challenge/app/presenter/stores/assets_store.dart';
import 'package:tractian_challenge/app/presenter/stores/company_store.dart';
import 'package:tractian_challenge/app/presenter/ui/pages/assets_page.dart';
import 'package:tractian_challenge/app/presenter/ui/pages/company_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<HttpClient>(DioHttpClient.new);

    i.add<CompanyRepository>(CompanyRepositoryImpl.new);
    i.add<AssetsRepository>(AssetsRepositoryImpl.new);
    // i.add<LocationRepository>(LocationRepositoryImpl.new);

    i.add(CompanyStore.new);
    i.add(AssetsStore.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child("/", child: (_) => const CompanyPage());
    r.child("/assets", child: (_) => AssetsPage(company: r.args.data));
  }
}
