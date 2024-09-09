import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:abbon_demo/features/app_layout/cubit/app_layout_cubit.dart';
import 'package:abbon_demo/features/app_layout/cubit/app_layout_state.dart';
import 'package:abbon_demo/features/contact/screen/contact_screen.dart';
import 'package:abbon_demo/features/home/bloc/home_bloc.dart';
import 'package:abbon_demo/features/home/screen/home_screen.dart';
import 'package:abbon_demo/features/setting/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> with TickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this, animationDuration: Duration.zero);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLayoutCubit, AppLayoutState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          body: Container(
            color: AppTheme.color.whiteColor,
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [],
              body: TabBarView(
                controller: _tabController,
                children: [
                  const Center(child: ContactScreen()),
                  const Center(child: HomeScreen()),
                  Center(child: SettingScreen()),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            iconSize: 24,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            selectedItemColor: AppTheme.color.tertiaryColor,
            selectedIconTheme: IconThemeData(color: AppTheme.color.tertiaryColor),
            selectedLabelStyle: GoogleFonts.mitr(
              textStyle: AppTheme.font.mitrS12,
              color: AppTheme.color.tertiaryColor,
            ),
            unselectedLabelStyle: GoogleFonts.mitr(
              textStyle: AppTheme.font.mitrS12,
              color: AppTheme.color.quaternaryColor,
            ),
            unselectedIconTheme: IconThemeData(color: AppTheme.color.quaternaryColor),
            unselectedItemColor: AppTheme.color.quaternaryColor,
            currentIndex: state.tabIndex ?? 0,
            onTap: (newIndex) {
              // if (snapX.data != null && snapX.data == true) {
              // _onBottomNavTap(
              //     mainState.screenIndex, newIndex, state.user);
              // } else { if (index == newIndex) {
              if (newIndex == 1) {
                // home screen
                context.read<HomeBloc>().add(FetchProfileEvent(onSuccess: () {
                  _tabController.animateTo(newIndex, duration: Duration.zero, curve: Curves.easeInOut);
                  context.read<AppLayoutCubit>().setTabIndex(index: newIndex);
                }));
              } else {
                _tabController.animateTo(newIndex, duration: Duration.zero, curve: Curves.easeInOut);
                context.read<AppLayoutCubit>().setTabIndex(index: newIndex);
              }
            },
            items: MenuEnums.values.map((e) => _buildTab(text: getMenuName(menu: e), icon: getMenuIcon(menu: e))).toList(),
          ),
        );
      },
    );
  }

  String getMenuName({required MenuEnums menu}) {
    switch (menu) {
      case MenuEnums.contact:
        return '${AppLocalizations.of(context)?.contact}';
      case MenuEnums.home:
        return '${AppLocalizations.of(context)?.home}';
      case MenuEnums.setting:
        return '${AppLocalizations.of(context)?.setting}';
    }
  }

  Icon getMenuIcon({required MenuEnums menu}) {
    switch (menu) {
      case MenuEnums.contact:
        return const Icon(
          Icons.contacts_rounded,
        );
      case MenuEnums.home:
        return const Icon(Icons.home_rounded);
      case MenuEnums.setting:
        return const Icon(Icons.settings_rounded);
    }
  }

  BottomNavigationBarItem _buildTab({required String text, required Widget icon}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: text,
    );
  }
}
