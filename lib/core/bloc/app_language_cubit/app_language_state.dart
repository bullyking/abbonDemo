import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:equatable/equatable.dart';

enum AppLanguageStatus {
  init,
  loading,
  success,
  error,
  restate,
}

extension SettingCompare on AppLanguageStatus {
  bool get isInit => this == AppLanguageStatus.init;
  bool get isLoading => this == AppLanguageStatus.loading;
  bool get isSuccess => this == AppLanguageStatus.success;
  bool get isError => this == AppLanguageStatus.error;
  bool get isRestate => this == AppLanguageStatus.restate;
}

class AppLanguageState extends Equatable {
  final LangEnums langValue;
  final AppLanguageStatus status;
  final String? errorMsg;

  const AppLanguageState.init({
    this.langValue = LangEnums.en,
    this.status = AppLanguageStatus.loading,
    this.errorMsg,
  });

  @override
  List<Object?> get props {
    return [
      langValue,
      status,
      errorMsg,
    ];
  }

  const AppLanguageState({
    this.langValue = LangEnums.en,
    required this.status,
    this.errorMsg,
  });

  AppLanguageState copyWith({
    LangEnums? langValue,
    AppLanguageStatus? status,
    String? errorMsg,
  }) {
    return AppLanguageState(
      langValue: langValue ?? this.langValue,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  Map<String, dynamic> toMapJson() {
    return {
      'langValue': langValue,
      'status': status,
      'errorMsg': errorMsg,
    };
  }

  factory AppLanguageState.fromMapJson(Map<String, dynamic> map) {
    return AppLanguageState(
      langValue: map['langValue'] as LangEnums,
      status: map['status'] as AppLanguageStatus,
      errorMsg: map['errorMsg'] as String,
    );
  }
}
