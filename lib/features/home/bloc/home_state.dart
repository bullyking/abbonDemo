part of 'home_bloc.dart';

enum HomeStatus {
  init,
  loading,
  success,
  error,
  restate,
}

extension HomeCompare on HomeStatus {
  bool get isInit => this == HomeStatus.init;
  bool get isLoading => this == HomeStatus.loading;
  bool get isSuccess => this == HomeStatus.success;
  bool get isError => this == HomeStatus.error;
  bool get isRestate => this == HomeStatus.restate;
}

class HomeState extends Equatable {
  final Profile? profile;
  final HomeStatus status;
  final String? errorMsg;

  const HomeState.init({
    this.profile,
    this.status = HomeStatus.loading,
    this.errorMsg,
  });

  @override
  List<Object?> get props {
    return [
      profile,
      status,
      errorMsg,
    ];
  }

  const HomeState({
    this.profile,
    required this.status,
    this.errorMsg,
  });

  HomeState copyWith({
    Profile? profile,
    HomeStatus? status,
    String? errorMsg,
  }) {
    return HomeState(
      profile: profile ?? this.profile,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  Map<String, dynamic> toMapJson() {
    return {
      'profile': profile?.toMap(),
      'status': status,
      'errorMsg': errorMsg,
    };
  }

  factory HomeState.fromMapJson(Map<String, dynamic> map) {
    return HomeState(
      profile: Profile.fromMap(map['profile']),
      status: map['status'] as HomeStatus,
      errorMsg: map['errorMsg'] as String,
    );
  }
}
