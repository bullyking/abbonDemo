// make contact from
import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:abbon_demo/core/extension/string_extension.dart';
import 'package:abbon_demo/core/service/dialog_service.dart';
import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:abbon_demo/core/widgets/app_form_field.dart';
import 'package:abbon_demo/core/widgets/button_widget.dart';
import 'package:abbon_demo/features/contact/cubit/contact_cubit.dart';
import 'package:abbon_demo/features/contact/cubit/contact_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({Key? key}) : super(key: key);

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  late final firstNameController = TextEditingController(text: null);
  late final lastNameController = TextEditingController(text: null);
  late final ageController = TextEditingController(text: null);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // get value from cubit state
    final contactState = context.read<ContactCubit>().state;
    final processType = contactState.processType ?? ProcessType.create;
    if (processType.isUpdate) {
      firstNameController.text = contactState.contactForm?.firstname ?? '';
      lastNameController.text = contactState.contactForm?.lastname ?? '';
      ageController.text = contactState.contactForm?.age.toString() ?? '';
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.color.whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.color.whiteColor),
        backgroundColor: AppTheme.color.tertiaryColor,
        title: Text('${AppLocalizations.of(context)?.formContact}',
            style: AppTheme.font.mitrS18.copyWith(color: AppTheme.color.whiteColor)),
      ),
      body: Container(
        constraints: const BoxConstraints.tightFor(width: 480),
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.sizeM, vertical: AppTheme.sizeM * 2),
        child: BlocConsumer<ContactCubit, ContactState>(
          bloc: context.read<ContactCubit>(),
          listener: (_, state) {
            //  handle when listen state...
          },
          builder: (context, state) {
            return Form(
              child: Column(
                children: <Widget>[
                  AppFormField(
                    controller: firstNameController,
                    hintText: '${AppLocalizations.of(context)?.firstName}',
                    title: '${AppLocalizations.of(context)?.firstName}',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    padding: const EdgeInsets.only(bottom: 0),
                    borderColor: state.contactFormState.firstNameField.value.isNullOrEmpty && state.isValidate == true
                        ? AppTheme.color.statusColorError
                        : AppTheme.color.tertiaryColor,
                    errorText: state.contactFormState.firstNameField.invalid ? '' : null,
                    onChanged: (String text) {
                      context.read<ContactCubit>().handleFirstName(value: text);
                    },
                  ),
                  const Gap(15),
                  AppFormField(
                    controller: lastNameController,
                    hintText: '${AppLocalizations.of(context)?.lastName}',
                    title: '${AppLocalizations.of(context)?.lastName}',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    borderColor: state.contactFormState.lastNameField.value.isNullOrEmpty && state.isValidate == true
                        ? AppTheme.color.statusColorError
                        : AppTheme.color.tertiaryColor,
                    errorText: state.contactFormState.lastNameField.invalid ? '' : null,
                    onChanged: (String text) {
                      context.read<ContactCubit>().handleLastName(value: text);
                    },
                  ),
                  AppFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    title: '${AppLocalizations.of(context)?.age}',
                    textInputAction: TextInputAction.next,
                    borderColor: state.contactFormState.ageField.value.isNullOrEmpty && state.isValidate == true
                        ? AppTheme.color.statusColorError
                        : AppTheme.color.tertiaryColor,
                    errorText: state.contactFormState.ageField.invalid ? '' : null,
                    hintText: '${AppLocalizations.of(context)?.age}',
                    onChanged: (String text) {
                      context.read<ContactCubit>().handleAge(value: text);
                    },
                    onValidator: (value) {
                      return null;
                    },
                  ),
                  ButtonDialog(
                    title: '${AppLocalizations.of(context)?.save}',
                    onTap: () {
                      if (state.contactFormState.isFormValid == false) {
                        context.read<ContactCubit>().invalidForm(onSuccess: () {
                          DialogService().showTopSnackbar(
                            context: context,
                            status: DialogStatus.error,
                            content: "${AppLocalizations.of(context)?.formInvalid}",
                          );
                        });
                      } else {
                        context.read<ContactCubit>().createContact(onSuccess: () {
                          Navigator.pop(context, 'save_success');
                        });
                      }
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
