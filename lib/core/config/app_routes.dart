import 'package:abbon_demo/features/app_layout/screen/app_layout.dart';
import 'package:abbon_demo/features/contact/cubit/contact_cubit.dart';
import 'package:abbon_demo/features/contact/cubit/contact_state.dart';
import 'package:abbon_demo/features/contact/router/contact_routes.dart';
import 'package:abbon_demo/features/contact/screen/contact_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Map<String, Widget Function(BuildContext)> appRoutes = {
  '/app_layout': (context) => const AppLayout(),
  '/contact/form': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as ContactArguments;
    return BlocBuilder<ContactCubit, ContactState>(
      bloc: context.read<ContactCubit>()..fetchForm(id: args.id, processType: args.processType),
      builder: (context, state) {
        return const ContactFormScreen();
      },
    );
  },
};
