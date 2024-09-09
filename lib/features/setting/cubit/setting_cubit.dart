import 'package:abbon_demo/features/Setting/cubit/Setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(const SettingState.init());
}
