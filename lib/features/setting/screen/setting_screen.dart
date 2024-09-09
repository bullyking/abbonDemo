import 'package:abbon_demo/core/bloc/app_language_cubit/app_language_cubit.dart';
import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.color.whiteColor,
      appBar: AppBar(
        backgroundColor: AppTheme.color.tertiaryColor,
        title: Text('${AppLocalizations.of(context)?.setting}',
            style: AppTheme.font.mitrS18.copyWith(
              color: AppTheme.color.whiteColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.sizeM, vertical: AppTheme.sizeM),
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [],
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${AppLocalizations.of(context)?.changeLanguage}', style: AppTheme.font.mitrS20),
                      const SizedBox(height: AppTheme.sizeM),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<AppLanguageCubit>().changeLanguage(langValue: LangEnums.en);
                              debugPrint('Change Language: ${AppLocalizations.of(context)?.language}');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: AppTheme.sizeM),
                              decoration: BoxDecoration(
                                color: AppLocalizations.of(context)?.language == 'en'
                                    ? AppTheme.color.secondaryColor
                                    : AppTheme.color.secondaryColor.withOpacity(.4),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                'EN',
                                style: AppTheme.font.mitrS16.copyWith(color: AppTheme.color.whiteColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: AppTheme.sizeM,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<AppLanguageCubit>().changeLanguage(langValue: LangEnums.th);
                              debugPrint('Change Language: ${AppLocalizations.of(context)?.language}');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: AppTheme.sizeM),
                              decoration: BoxDecoration(
                                color: AppLocalizations.of(context)?.language == 'th'
                                    ? AppTheme.color.secondaryColor
                                    : AppTheme.color.secondaryColor.withOpacity(.4),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                'TH',
                                style: AppTheme.font.mitrS16.copyWith(color: AppTheme.color.whiteColor),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: AppTheme.sizeM,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${AppLocalizations.of(context)?.openNotification}',
                              style: AppTheme.font.mitrS20.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(width: AppTheme.sizeM),
                          GestureDetector(
                            onTap: () {
                              debugPrint('Open Notification Setting');
                              AppSettings.openAppSettings(type: AppSettingsType.notification);
                            },
                            child: Container(
                              width: 50,
                              padding: const EdgeInsets.all(AppTheme.sizeM),
                              decoration: BoxDecoration(
                                color: AppTheme.color.tertiaryColor,
                                borderRadius: BorderRadius.circular(AppTheme.sizeXL * 2),
                              ),
                              child: Image.asset(
                                'assets/images/icons/setting_blue.png',
                                width: 5,
                                color: AppTheme.color.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
