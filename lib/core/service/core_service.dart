import 'package:flutter/material.dart';

class CoreService {
  static final CoreService _dialogService = CoreService._internal();

  factory CoreService() {
    return _dialogService;
  }

  CoreService._internal();

  bool handleArguments(BuildContext ctx) {
    return ModalRoute.of(ctx)!.settings.arguments != null;
  }
}
