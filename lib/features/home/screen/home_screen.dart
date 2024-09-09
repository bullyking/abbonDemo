import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:abbon_demo/features/home/bloc/home_bloc.dart';
import 'package:abbon_demo/features/home/widgets/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nestedScroollController = ScrollController();
  final scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();

    nestedScroollController.dispose();
    scrollController.dispose();

    context.read<HomeBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.color.whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.color.whiteColor),
        backgroundColor: AppTheme.color.tertiaryColor,
        title: Text('${AppLocalizations.of(context)?.home}',
            style: AppTheme.font.mitrS18.copyWith(
              color: AppTheme.color.whiteColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.sizeM, vertical: AppTheme.sizeM),
        child: NestedScrollView(
            // controller: nestedScroollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [],
            body: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) => previous.profile != current.profile,
                    builder: (context, state) {
                      return MyProfile(
                        profile: state.profile,
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
