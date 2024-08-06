import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/interaction/models/location_model.dart';

class LocationModelWidget extends StatelessWidget {
  final LocationModel item;
  final bool isExpanded;
  final bool showArrow;
  final void Function()? onTap;

  const LocationModelWidget({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.showArrow,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          if (showArrow)
            Icon(
              isExpanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_right_rounded,
            ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(
              Icons.place_outlined,
              color: colorScheme.primaryContainer,
            ),
          ),
          Flexible(
            child: Text(
              item.name,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
