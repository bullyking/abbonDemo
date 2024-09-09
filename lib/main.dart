import 'package:abbon_demo/core/bloc/app_language_cubit/app_language_cubit.dart';
import 'package:abbon_demo/core/bloc/app_language_cubit/app_language_state.dart';
import 'package:abbon_demo/core/config/app_routes.dart';
import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:abbon_demo/features/app_layout/cubit/app_layout_cubit.dart';
import 'package:abbon_demo/features/app_layout/screen/splash_screen.dart';
import 'package:abbon_demo/features/contact/cubit/contact_cubit.dart';
import 'package:abbon_demo/features/home/bloc/home_bloc.dart';
import 'package:abbon_demo/features/setting/cubit/setting_cubit.dart';
import 'package:abbon_demo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AppLanguageCubit>(
        create: (_) => AppLanguageCubit()..initLanguage,
      ),
      BlocProvider<AppLayoutCubit>(
        create: (_) => AppLayoutCubit(),
      ),
      BlocProvider<ContactCubit>(
        create: (_) => ContactCubit()..fetchContactList,
      ),
      BlocProvider<HomeBloc>(create: (_) => HomeBloc()..add(const FetchProfileEvent())),
      BlocProvider<SettingCubit>(
        create: (_) => SettingCubit(),
      ),
    ],
    child: const AppInit(),
  ));
}

class AppInit extends StatefulWidget {
  const AppInit({
    Key? key,
  }) : super(key: key);

  @override
  State<AppInit> createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLanguageCubit, AppLanguageState>(
      bloc: context.read<AppLanguageCubit>(),
      builder: (context, langState) {
        return MaterialApp(
          title: 'Abbon Test',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
          supportedLocales: L10n.all,
          locale: Locale(langState.langValue.describe),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          navigatorKey: navigatorKey,
          routes: appRoutes,
        );
      },
    );
  }
}
