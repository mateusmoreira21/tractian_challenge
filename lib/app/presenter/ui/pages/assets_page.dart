// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tractian_challenge/app/core/extensions/context_extesions.dart';
import 'package:tractian_challenge/app/interaction/models/company_model.dart';
import 'package:tractian_challenge/app/interaction/models/tree_model.dart';
import 'package:tractian_challenge/app/presenter/states/assets_state.dart';
import 'package:tractian_challenge/app/presenter/stores/assets_store.dart';
import 'package:tractian_challenge/app/presenter/ui/widgets/buttons/select_button.dart';
import 'package:tractian_challenge/app/presenter/ui/widgets/buttons/toggle_button.dart';
import 'package:tractian_challenge/app/presenter/ui/widgets/input/search_text_field.dart';
import 'package:tractian_challenge/app/presenter/ui/widgets/tiles/expanded_tile_list.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key, required this.company});
  final CompanyModel company;

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final store = Modular.get<AssetsStore>();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    store.load(widget.company.id);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.select(() => store.state);

    final List<TreeModel> listTree = state.treesFiltered;
    listTree.sort((a, b) => b.children.length.compareTo(a.children.length));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.company.name} Assets',
          style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary),
        ),
      ),
      body: Padding(
        padding: context.viewPadding,
        child: Column(
          children: [
            if (state is StartAssetsState) const Center(child: CircularProgressIndicator.adaptive()),
            if (state is LoadedAssetsState) ...[
              SearchTextField(
                controller: _controller,
                onChanged: (text) => store.filterBySearchText(text),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SelectButton(
                  onUnselectAll: store.resetTree,
                  children: [
                    ToggleButton(
                        icon: Icons.bolt,
                        text: 'Sensor de Energia',
                        onPressed: () {
                          _controller.clear();
                          store.filterBySensors();
                        }),
                    ToggleButton(
                      icon: Icons.error_outline,
                      text: 'Crítico',
                      onPressed: () {
                        _controller.clear();
                        store.filterByCriticalAlerts();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: listTree.length,
                  separatorBuilder: (context, index) => const SizedBox(),
                  itemBuilder: (context, index) {
                    final item = listTree[index];
                    return ExpansibleTileList(item: item);
                  },
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
