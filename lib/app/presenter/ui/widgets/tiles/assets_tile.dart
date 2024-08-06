import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/interaction/models/assets_model.dart';

class AssetsModelWidget extends StatelessWidget {
  final AssetsModel item;
  final bool isExpanded;
  final bool isComponent;
  final void Function()? onTap;

  const AssetsModelWidget({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.isComponent,
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
          if (!isComponent)
            Icon(
              isExpanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_right_rounded,
            ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              isComponent ? "assets/components.png" : "assets/assets.png",
              height: 20,
              color: colorScheme.primaryContainer,
            ),
          ),
          Flexible(
            child: Text(
              item.name,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          if (item.sensorType.contains('energy'))
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.bolt_rounded,
                color: Colors.green,
                size: 18,
              ),
            ),
          if (item.status.contains('alert'))
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.circle,
                size: 12,
                color: colorScheme.error,
              ),
            ),
        ],
      ),
    );
  }
}
