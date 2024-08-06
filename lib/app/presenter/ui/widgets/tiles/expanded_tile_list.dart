import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/interaction/models/assets_model.dart';
import 'package:tractian_challenge/app/interaction/models/location_model.dart';
import 'package:tractian_challenge/app/interaction/models/tree_model.dart';
import 'package:tractian_challenge/app/presenter/ui/widgets/tiles/assets_tile.dart';

import 'location_tile.dart';

class ExpansibleTileList extends StatefulWidget {
  const ExpansibleTileList({super.key, required this.item});
  final TreeModel item;
  // final List<TreeModel> listTree;

  @override
  State<ExpansibleTileList> createState() => _ExpansibleTileListState();
}

class _ExpansibleTileListState extends State<ExpansibleTileList> {
  bool isExpanded = false;
  late bool itemEmpty;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        if (widget.item is LocationModel)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: LocationModelWidget(
              item: widget.item as LocationModel,
              isExpanded: isExpanded,
              showArrow: widget.item.children.isNotEmpty,
              onTap: widget.item.children.isEmpty ? null : changeExpanded,
            ),
          )
        else if (widget.item is AssetsModel)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: AssetsModelWidget(
              item: widget.item as AssetsModel,
              isExpanded: isExpanded,
              isComponent: widget.item.children.isEmpty || (widget.item as AssetsModel).sensorType.isNotEmpty,
              onTap: widget.item.children.isEmpty ? null : changeExpanded,
            ),
          ),
        if (isExpanded)
          Container(
            margin: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              border: !isExpanded
                  ? null
                  : Border(
                      left: BorderSide(
                      color: colorScheme.secondaryFixed,
                    )),
            ),
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.item.children.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemBuilder: (context, index) {
                final item = widget.item.children[index];
                return ExpansibleTileList(item: item);
              },
            ),
          ),
      ],
    );
  }

  changeExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
