part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileEvent extends HomeEvent {
  const FetchProfileEvent({this.onSuccess});
  final Function? onSuccess;

  @override
  List<Object> get props => [];
}

class OpenLocationEvent extends HomeEvent {
  const OpenLocationEvent({this.callback});

  final Function? callback;

  @override
  List<Object> get props => [];
}

class SelectOrTakeImageEvent extends HomeEvent {
  const SelectOrTakeImageEvent({required this.imageType, this.onSuccess});
  final ImageType imageType;
  final Function? onSuccess;

  @override
  List<Object> get props => [];
}
