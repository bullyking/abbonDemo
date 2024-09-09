import 'package:abbon_demo/features/app_layout/cubit/app_layout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayoutCubit extends Cubit<AppLayoutState> {
  AppLayoutCubit() : super(const AppLayoutState.init());

  Future<void> setTabIndex({required int index}) async {
    emit(state.copyWith(status: AppLayoutStatus.restate));
    try {
      emit(state.copyWith(
        status: AppLayoutStatus.success,
        tabIndex: index,
      ));
    } catch (ex) {
      emit(state.copyWith(status: AppLayoutStatus.error, errorMsg: ''));
    }
  }
}
