import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:abbon_demo/core/models/contact/contact.dart';
import 'package:abbon_demo/core/service/dialog_service.dart';
import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:abbon_demo/features/contact/cubit/contact_cubit.dart';
import 'package:abbon_demo/features/contact/cubit/contact_state.dart';
import 'package:abbon_demo/features/contact/router/contact_routes.dart';
import 'package:abbon_demo/features/contact/widgets/search_widget.dart';
import 'package:abbon_demo/features/share_widgets/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../main.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final scrollController = ScrollController();
  final contactListScroll = ScrollController();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    contactListScroll.addListener(() {
      if (contactListScroll.position.maxScrollExtent == contactListScroll.offset) {
        context.read<ContactCubit>().refetchContactList;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    contactListScroll.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.color.tertiaryColor,
        title: Text('${AppLocalizations.of(context)?.contact}',
            style: AppTheme.font.mitrS18.copyWith(
              color: AppTheme.color.whiteColor,
            )),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const Gap(AppTheme.sizeM),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.sizeM),
              child: SearchWidget(
                searchController: searchController,
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height - 250,
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.sizeM),
                child: BlocBuilder<ContactCubit, ContactState>(
                  bloc: context.read<ContactCubit>(),
                  builder: (context, state) {
                    final contactList = state.contactList ?? [];

                    return ListView.builder(
                      controller: contactListScroll,
                      itemCount: contactList.length + 1,
                      itemBuilder: (context, index) {
                        return index < contactList.length
                            ? ListTile(
                                title: Text(
                                  '${AppLocalizations.of(context)?.firstNameShort} ${contactList[index].firstname} ${contactList[index].lastname}',
                                  style: AppTheme.font.mitrS16,
                                ),
                                subtitle: Text(
                                  '${AppLocalizations.of(context)?.age} ${contactList[index].age}',
                                  style: AppTheme.font.mitrS16,
                                ),
                                leading: CircleAvatar(
                                  child: Image.asset('assets/images/profile/avatar_default.png'),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    context.read<ContactCubit>().deleteContact(
                                        id: contactList[index].id,
                                        onSuccess: () {
                                          DialogService().showTopSnackbar(
                                            context: context,
                                            status: DialogStatus.success,
                                            content: "${AppLocalizations.of(context)?.deleteContactSuccess}",
                                          );
                                        });
                                  },
                                ),
                              )
                            : state.hasMore == true
                                ? const LoadingWidget(
                                    hasBgColor: false,
                                  )
                                : Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${AppLocalizations.of(context)?.reachMaxItem}',
                                      style: AppTheme.font.mitrS16,
                                    ));
                      },
                    );
                  },
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.color.primaryColor,
        onPressed: () async {
          debugPrint('add contact');
          FocusScope.of(context).unfocus();
          final result = await navigatorKey.currentState?.pushNamed('/contact/form',
              arguments: const ContactArguments(
                id: 0,
                processType: ProcessType.create,
              ));

          if (result != null) {
            searchController.text = '';
            DialogService().showTopSnackbar(
              context: context,
              status: DialogStatus.success,
              content: "${AppLocalizations.of(context)?.addContactSuccess}",
            );
          }
        },
        child: Icon(
          Icons.add,
          color: AppTheme.color.tertiaryColor,
        ),
      ), //
    );
  }
}
