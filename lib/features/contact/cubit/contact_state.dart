import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:abbon_demo/core/models/contact/contact.dart';
import 'package:abbon_demo/features/contact/cubit/contact_form_state.dart';
import 'package:equatable/equatable.dart';

enum ContactStatus { init, loading, success, error, restate, loadMore, saveSuccess, saveError }

extension ContactCompare on ContactStatus {
  bool get isInit => this == ContactStatus.init;
  bool get isLoading => this == ContactStatus.loading;
  bool get isSuccess => this == ContactStatus.success;
  bool get isError => this == ContactStatus.error;
  bool get isRestate => this == ContactStatus.restate;
  bool get isLoadMore => this == ContactStatus.loadMore;
  bool get isSaveSuccess => this == ContactStatus.saveSuccess;
  bool get isSaveError => this == ContactStatus.saveError;
}

class ContactState extends Equatable {
  final List<Contact>? contactList;
  final List<Contact>? searchContactList;
  final ContactFormState contactFormState;
  final SearchType? searchType;
  final Contact? contactForm;
  final ProcessType? processType;
  final int currentPage;
  final int? pageSize;
  final bool? hasMore;
  final bool? isValidate;
  final ContactStatus status;
  final String? errorMsg;

  const ContactState.init({
    this.contactList,
    this.searchContactList,
    required this.contactFormState,
    this.searchType = SearchType.all,
    this.contactForm,
    this.processType = ProcessType.create,
    this.currentPage = 0,
    this.pageSize = 20,
    this.hasMore = true,
    this.isValidate,
    this.status = ContactStatus.loading,
    this.errorMsg,
  });

  @override
  List<Object?> get props {
    return [
      contactList,
      searchContactList,
      contactFormState,
      searchType,
      contactForm,
      processType,
      currentPage,
      pageSize,
      hasMore,
      isValidate,
      status,
      errorMsg,
    ];
  }

  ContactState copyWith({
    List<Contact>? contactList,
    List<Contact>? searchContactList,
    ContactFormState? contactFormState,
    SearchType? searchType,
    Contact? contactForm,
    ProcessType? processType,
    int? currentPage,
    int? pageSize,
    bool? hasMore,
    bool? isValidate,
    ContactStatus? status,
    String? errorMsg,
  }) {
    return ContactState(
      contactList: contactList ?? this.contactList,
      searchContactList: searchContactList ?? this.searchContactList,
      contactFormState: contactFormState ?? this.contactFormState,
      searchType: searchType ?? this.searchType,
      contactForm: contactForm ?? this.contactForm,
      processType: processType ?? this.processType,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      hasMore: hasMore ?? this.hasMore,
      isValidate: isValidate ?? this.isValidate,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  Map<String, dynamic> toMapJson() {
    return {
      'contactList': contactList,
      'searchContact': searchContactList,
      'contactFormState': contactFormState,
      'searchType': searchType,
      'contactForm': contactForm,
      'processType': processType,
      'currentPage': currentPage,
      'pageSize': pageSize,
      'hasMore': hasMore,
      'isValidate': isValidate,
      'status': status,
      'errorMsg': errorMsg,
    };
  }

  const ContactState({
    this.contactList,
    this.searchContactList,
    required this.contactFormState,
    this.searchType = SearchType.all,
    this.contactForm,
    this.processType = ProcessType.create,
    this.currentPage = 0,
    this.pageSize,
    this.hasMore,
    this.isValidate,
    this.status = ContactStatus.loading,
    this.errorMsg,
  });

  factory ContactState.fromMapJson(Map<String, dynamic> map) {
    return ContactState(
      contactList: map['contactList'] as List<Contact>,
      searchContactList: map['searchContactList'] as List<Contact>,
      contactFormState: map['contactFormState'] as ContactFormState,
      searchType: map['searchType'] as SearchType,
      contactForm: map['contactForm'] as Contact,
      processType: map['processType'] as ProcessType,
      currentPage: map['currentPage'] as int,
      pageSize: map['pageSize'] as int,
      hasMore: map['hasMore'] as bool,
      isValidate: map['isValidate'] as bool,
      status: map['status'] as ContactStatus,
      errorMsg: map['errorMsg'] as String,
    );
  }
}
