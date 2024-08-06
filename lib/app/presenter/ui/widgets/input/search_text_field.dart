// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/extensions/context_extesions.dart';

class SearchTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const SearchTextField({
    super.key,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.colorScheme.secondaryFixed,
        prefixIcon: Icon(Icons.search, color: theme.colorScheme.onSecondaryFixed),
        hintText: 'Buscar ativo ou local',
        hintStyle: TextStyle(color: theme.colorScheme.onSecondaryFixed),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
