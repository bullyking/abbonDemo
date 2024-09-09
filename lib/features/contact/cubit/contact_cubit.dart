import 'dart:async';

import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:abbon_demo/core/extension/string_extension.dart';
import 'package:abbon_demo/core/models/contact/contact.dart';
import 'package:abbon_demo/core/service/paginate_service.dart';
import 'package:abbon_demo/features/contact/cubit/contact_form_state.dart';
import 'package:abbon_demo/features/contact/cubit/contact_state.dart';
import 'package:abbon_demo/features/contact/formz/age_field.dart';
import 'package:abbon_demo/features/contact/formz/firstname_field.dart';
import 'package:abbon_demo/features/contact/formz/lastname_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit()
      : super(const ContactState.init(
          contactFormState: ContactFormState.pure(),
        ));

  FutureOr<void> get init async {
    fetchContactList;
  }

  FutureOr<void> get fetchContactList async {
    try {
      final contactListFromState = state.contactList ?? [];
      final lengthOfContact = contactListFromState.length ?? 0;
      final count = lengthOfContact > 80 ? (100 - lengthOfContact) : 20;
      final getContactList = PaginatedService().mockContactList(count: count);
      debugPrint('getContactList => ${contactListToJson(data: getContactList)}');
      final contactList = contactListFromState + getContactList;
      emit(state.copyWith(
        contactList: contactList,
        isValidate: false,
        hasMore: lengthOfContact > 80 == false,
      ));
    } catch (ex) {
      emit(state.copyWith(status: ContactStatus.error, errorMsg: ''));
    }
  }

  FutureOr<void> get refetchContactList {
    fetchContactList;
  }

  FutureOr<void> searchContact({String? searchValue}) {
    emit(state.copyWith(status: ContactStatus.loading));

    // search when searchValue is length  more than 2
    if (searchValue!.length < 2) {
      emit(state.copyWith(
        status: ContactStatus.success,
        contactList: state.contactList,
        searchType: SearchType.all,
      ));
    } else {
      // search with firstname and lastname
      final contactList = state.contactList ?? [];
      final List<Contact> searchResult = contactList.where((item) {
        return item.firstname.toLowerCase().contains(searchValue.toLowerCase()) ||
            item.lastname.toLowerCase().contains(searchValue.toLowerCase());
      }).toList();

      emit(state.copyWith(
        status: ContactStatus.success,
        searchContactList: searchResult,
        searchType: SearchType.search,
        isValidate: false,
      ));
    }
  }

  // clear search
  FutureOr<void> get clearSearch {
    emit(state.copyWith(
      status: ContactStatus.success,
      contactList: [],
      searchType: SearchType.all,
      isValidate: false,
    ));
  }

  FutureOr<void> fetchForm({int? id, ProcessType? processType}) {
    emit(state.copyWith(processType: processType));
    try {
      if (processType == ProcessType.update) {
        final result = state.contactList?.firstWhere((element) => element.id == id);

        debugPrint('result => ${result?.toMap()}');
        if (result != null) {
          final contactFormState = state.contactFormState.copyWith(
              firstNameField: FirstNameField.pure(value: state.contactForm?.firstname),
              lastNameField: LastNameField.pure(value: state.contactForm?.lastname),
              ageField: AgeField.pure(value: state.contactForm?.age.toString()));

          emit(state.copyWith(
            contactForm: result,
            contactFormState: contactFormState,
          ));
        } else {
          emit(state.copyWith(status: ContactStatus.error));
        }
      } else {
        // handle fetch new form
        final contactFormState = state.contactFormState.copyWith(
            firstNameField: const FirstNameField.pure(value: ''),
            lastNameField: const LastNameField.pure(value: ''),
            ageField: const AgeField.pure(value: ''));

        emit(state.copyWith(
          contactForm: Contact.init(),
          contactFormState: contactFormState,
        ));
      }
    } catch (ex) {
      emit(state.copyWith(status: ContactStatus.error, errorMsg: ''));
    }
  }

  void handleFirstName({String? value}) {
    emit(state.copyWith(status: ContactStatus.restate));
    try {
      final contactForm = Contact(
        id: state.contactForm?.id ?? 0,
        firstname: value ?? '',
        lastname: state.contactForm?.lastname ?? '',
        age: state.contactForm?.age ?? 0,
      );

      final contactFormState = state.contactFormState.copyWith(firstNameField: FirstNameField.dirty(value: value));

      emit(state.copyWith(
        contactForm: contactForm,
        contactFormState: contactFormState,
      ));
    } catch (e) {
      debugPrint('error => $e');
      emit(state.copyWith(status: ContactStatus.error, errorMsg: ''));
    }
  }

  void handleLastName({String? value}) {
    emit(state.copyWith(status: ContactStatus.restate));
    try {
      final contactForm = Contact(
        id: state.contactForm?.id ?? 0,
        firstname: state.contactForm?.firstname ?? '',
        lastname: value ?? '',
        age: state.contactForm?.age ?? 0,
      );

      emit(state.copyWith(
        contactForm: contactForm,
        contactFormState: state.contactFormState.copyWith(lastNameField: LastNameField.dirty(value: value)),
        status: ContactStatus.success,
        isValidate: false,
      ));
    } catch (e) {
      debugPrint('error => $e');
      emit(state.copyWith(status: ContactStatus.error, errorMsg: ''));
    }
  }

  void handleAge({String? value}) {
    try {
      final ageValue = value.isNullOrEmpty ? int.parse('0') : int.parse(value ?? '0');

      final contactForm = Contact(
        id: state.contactForm?.id ?? 0,
        firstname: state.contactForm?.firstname ?? '',
        lastname: state.contactForm?.lastname ?? '',
        age: ageValue,
      );
      emit(state.copyWith(
        contactForm: contactForm,
        contactFormState: state.contactFormState.copyWith(ageField: AgeField.dirty(value: ageValue.toString())),
        status: ContactStatus.success,
        isValidate: false,
      ));
    } catch (e) {
      debugPrint('error => $e');
      emit(state.copyWith(status: ContactStatus.error, errorMsg: ''));
    }
  }

  FutureOr<void> invalidForm({Function? onSuccess}) {
    emit(state.copyWith(status: ContactStatus.restate));
    // final contactList = state.contactList ?? [];
    final contact = state.contactForm ?? Contact.init();
    final contactForm = Contact(
      id: state.contactForm?.id ?? 0,
      firstname: state.contactForm?.firstname ?? '',
      lastname: state.contactForm?.lastname ?? '',
      age: state.contactForm?.age ?? 0,
    );

    final contactFormState = state.contactFormState.copyWith(
      firstNameField: FirstNameField.dirty(value: contact.firstname),
      lastNameField: LastNameField.dirty(value: contact.lastname),
      ageField: AgeField.dirty(value: contact.age.toString()),
    );

    emit(state.copyWith(
      contactForm: contactForm,
      contactFormState: contactFormState,
      status: ContactStatus.saveError,
      isValidate: true,
    ));

    if (onSuccess != null) onSuccess.call();
  }

  // create new contact
  FutureOr<void> createContact({Function? onSuccess}) {
    final processType = state.processType ?? ProcessType.create;
    final contact = state.contactForm ?? Contact.init();
    if (processType.isCreate) {
      final contactList = state.contactList ?? [];
      final newContactList = [
        Contact(
          id: contactList.length + 1,
          firstname: contact.firstname,
          lastname: contact.lastname,
          age: contact.age,
        ),
        ...contactList,
      ];

      clearSearch;

      emit(state.copyWith(
        status: ContactStatus.saveSuccess,
        contactList: newContactList,
      ));

      emit(state.copyWith(
        status: ContactStatus.success,
      ));

      if (onSuccess != null) onSuccess.call();
    }
  }

  // delete selected contact
  FutureOr<void> deleteContact({int? id, Function? onSuccess}) {
    try {
      final contactList = state.contactList ?? [];
      final newContactList = contactList.where((element) => element.id != id).toList();

      emit(state.copyWith(
        status: ContactStatus.success,
        contactList: newContactList,
        isValidate: false,
      ));

      if (onSuccess != null) onSuccess.call();
    } catch (e) {
      debugPrint('error => $e');
      emit(state.copyWith(status: ContactStatus.error, errorMsg: ''));
    }
  }
}
