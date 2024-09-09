import 'package:equatable/equatable.dart';

enum AppLayoutStatus {
  init,
  loading,
  success,
  error,
  restate,
}

extension AppLayoutCompare on AppLayoutStatus {
  bool get isInit => this == AppLayoutStatus.init;
  bool get isLoading => this == AppLayoutStatus.loading;
  bool get isSuccess => this == AppLayoutStatus.success;
  bool get isError => this == AppLayoutStatus.error;
  bool get isRestate => this == AppLayoutStatus.restate;
}

class AppLayoutState extends Equatable {
  final int? tabIndex;
  final AppLayoutStatus status;
  final String? errorMsg;

  const AppLayoutState.init({
    this.tabIndex = 0,
    this.status = AppLayoutStatus.loading,
    this.errorMsg,
  });

  @override
  List<Object?> get props {
    return [
      tabIndex,
      status,
      errorMsg,
    ];
  }

  const AppLayoutState({
    this.tabIndex,
    required this.status,
    this.errorMsg,
  });

  AppLayoutState copyWith({
    int? tabIndex,
    AppLayoutStatus? status,
    String? errorMsg,
  }) {
    return AppLayoutState(
      tabIndex: tabIndex ?? this.tabIndex,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  Map<String, dynamic> toMapJson() {
    return {
      'tabIndex': tabIndex,
      'status': status,
      'errorMsg': errorMsg,
    };
  }

  factory AppLayoutState.fromMapJson(Map<String, dynamic> map) {
    return AppLayoutState(
      tabIndex: map['tabIndex'] as int,
      status: map['status'] as AppLayoutStatus,
      errorMsg: map['errorMsg'] as String,
    );
  }
}
