import 'package:abbon_demo/core/bloc/app_language_cubit/app_language_state.dart';
import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageCubit extends Cubit<AppLanguageState> {
  AppLanguageCubit() : super(const AppLanguageState.init());

  void get initLanguage async {
    emit(state.copyWith(status: AppLanguageStatus.loading));

    final prefs = await SharedPreferences.getInstance();

    final lang = prefs.getString('lang') ?? 'en';
    emit(state.copyWith(
      status: AppLanguageStatus.success,
      langValue: lang == 'en' ? LangEnums.en : LangEnums.th,
    ));
  }

  void changeLanguage({required LangEnums langValue}) async {
    emit(state.copyWith(status: AppLanguageStatus.loading));

    final prefs = await SharedPreferences.getInstance();
    final langString = langValue == LangEnums.en ? 'en' : 'th';
    prefs.setString('lang', langString);

    emit(state.copyWith(
      status: AppLanguageStatus.success,
      langValue: langString == 'en' ? LangEnums.en : LangEnums.th,
    ));
  }
}
