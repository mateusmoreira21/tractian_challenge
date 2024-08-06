import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/presenter/ui/widgets/buttons/toggle_button.dart';

class SelectButton extends StatefulWidget {
  final List<ToggleButton> children;
  final void Function()? onUnselectAll;

  const SelectButton({
    super.key,
    required this.children,
    required this.onUnselectAll,
  });

  @override
  SelectableButtonsState createState() => SelectableButtonsState();
}

class SelectableButtonsState extends State<SelectButton> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List<Widget>.generate(widget.children.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (selectedIndex == index) {
                selectedIndex = -1;
                widget.onUnselectAll?.call();
              } else {
                selectedIndex = index;
                widget.children[index].onPressed?.call();
              }
            });
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: selectedIndex == index ? colorScheme.primaryContainer : colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: selectedIndex == index ? colorScheme.primaryContainer : colorScheme.primary,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  (widget.children[index]).icon,
                  color: selectedIndex == index ? colorScheme.onPrimary : colorScheme.primary,
                ),
                const SizedBox(width: 8.0),
                Text(
                  (widget.children[index]).text,
                  style: TextStyle(
                    color: selectedIndex == index ? colorScheme.onPrimary : colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
