import 'package:equatable/equatable.dart';

enum SettingStatus {
  init,
  loading,
  success,
  error,
  restate,
}

extension SettingCompare on SettingStatus {
  bool get isInit => this == SettingStatus.init;
  bool get isLoading => this == SettingStatus.loading;
  bool get isSuccess => this == SettingStatus.success;
  bool get isError => this == SettingStatus.error;
  bool get isRestate => this == SettingStatus.restate;
}

class SettingState extends Equatable {
  final SettingStatus status;
  final String? errorMsg;

  const SettingState.init({
    this.status = SettingStatus.loading,
    this.errorMsg,
  });

  @override
  List<Object?> get props {
    return [
      status,
      errorMsg,
    ];
  }

  const SettingState({
    required this.status,
    this.errorMsg,
  });

  SettingState copyWith({
    SettingStatus? status,
    String? errorMsg,
  }) {
    return SettingState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  Map<String, dynamic> toMapJson() {
    return {
      'status': status,
      'errorMsg': errorMsg,
    };
  }

  factory SettingState.fromMapJson(Map<String, dynamic> map) {
    return SettingState(
      status: map['status'] as SettingStatus,
      errorMsg: map['errorMsg'] as String,
    );
  }
}
