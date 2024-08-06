import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tractian_challenge/app/core/extensions/context_extesions.dart';
import 'package:tractian_challenge/app/presenter/states/company_state.dart';
import 'package:tractian_challenge/app/presenter/stores/company_store.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  final store = Modular.get<CompanyStore>();

  @override
  void initState() {
    store.getAllCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select(() => store.state);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(
          'assets/tractian_logo.svg',
          width: context.pWidth(.35),
          semanticsLabel: 'Tractian Logo',
          colorFilter: ColorFilter.mode(
            context.theme.colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
      ),
      body: Padding(
        padding: context.viewPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (state is StartCompanyState) const Center(child: CircularProgressIndicator.adaptive()),
            if (state is ErrorCompanyState) Center(child: Text(state.message)),
            if (state is LoadedCompanyState)
              Expanded(
                child: Column(
                  children: state.companies //
                      .map(
                        (company) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: ListTile(
                            onTap: () => Modular.to.pushNamed("/assets", arguments: company),
                            shape: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide.none,
                            ),
                            minTileHeight: 80,
                            tileColor: context.theme.colorScheme.primaryContainer,
                            leading: Icon(Icons.store_rounded, color: context.theme.colorScheme.onPrimary),
                            title: Text(
                              company.name,
                              style: context.theme.textTheme.headlineSmall!.copyWith(color: context.theme.colorScheme.onPrimary),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
