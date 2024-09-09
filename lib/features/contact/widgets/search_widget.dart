import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:abbon_demo/features/contact/cubit/contact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:abbon_demo/core/extension/string_extension.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                hintText: '${AppLocalizations.of(context)?.search}',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              onChanged: (value) {
                context.read<ContactCubit>().searchContact(searchValue: value);
              }),
        ),
        const SizedBox(
          width: AppTheme.sizeM,
        ),
        GestureDetector(
          onTap: () {
            if (searchController.text.isNullOrEmpty) return;
            searchController.clear();
            context.read<ContactCubit>().clearSearch;
          },
          child: Container(
              height: 40,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.color.whiteColor,
                border: Border.all(
                  color: AppTheme.color.borderColor,
                ),
              ),
              child: ImageIcon(
                const AssetImage("assets/images/icons/ic_close.png"),
                color: AppTheme.color.tertiaryColor,
              )),
        )
      ],
    );
  }
}
