import 'dart:async';
import 'dart:math' as math;

import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogService {
  static final DialogService _dialogService = DialogService._internal();

  factory DialogService() {
    return _dialogService;
  }

  DialogService._internal();

  final Map<DialogStatus, Color> _snackBarBgColor = {
    DialogStatus.error: const Color(0xFFfff6f7),
    DialogStatus.success: const Color(0xFFf5fcfa),
    DialogStatus.invalid: const Color(0xFFfffbf7),
    DialogStatus.info: const Color(0xFFf1f9ff),
  };

  final Map<DialogStatus, Color> _snackBarBorderColor = {
    DialogStatus.error: const Color(0xFFf7575f),
    DialogStatus.success: const Color(0xFF48bea2),
    DialogStatus.invalid: const Color(0xFFffb033),
    DialogStatus.info: const Color(0xFF79beff),
  };

  final Map<DialogStatus, String> _snackBarIcon = {
    DialogStatus.error: "assets/images/icons/error_icon.png",
    DialogStatus.success: "assets/images/icons/success_icon.png",
    DialogStatus.invalid: "assets/images/icons/ic_info.png",
    DialogStatus.info: "assets/images/icons/info.png",
  };

  Future<void> showLoadingDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true,
  }) async {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        useSafeArea: true,
        builder: (BuildContext context) {
          return const AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            content: _AbbonLoading(),
          );
        });
  }

  Flushbar<dynamic> showTopSnackbar({
    required BuildContext context,
    required DialogStatus status,
    required String? content,
  }) {
    late Flushbar flush;
    if ((content ?? "").contains("Forbidden") || (content ?? "").contains("consent version")) {
      return flush = Flushbar()..dismiss();
    }
    flush = Flushbar(
      isDismissible: true,
      duration: const Duration(seconds: 3),
      backgroundColor: _snackBarBgColor[status]!,
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8),
      borderColor: _snackBarBorderColor[status]!,
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.sizeS).copyWith(top: AppTheme.sizeS),
      icon: Image.asset(
        _snackBarIcon[status]!,
        width: 24,
        height: 24,
      ),
      mainButton: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: GestureDetector(
            onTap: () => flush.dismiss(),
            child: const Icon(
              Icons.close,
              size: 24,
            )),
      ),
      messageText: Text(
        content ?? '',
        style: GoogleFonts.sarabun(textStyle: AppTheme.font.mitrS14),
      ),
      titleColor: AppTheme.color.primaryColor,
      titleSize: AppTheme.sizeM,
    )..show(context);

    return flush;
  }
}

class _AbbonLoading extends StatefulWidget {
  const _AbbonLoading({Key? key}) : super(key: key);

  @override
  State<_AbbonLoading> createState() => _AbbonLoadingState();
}

class _AbbonLoadingState extends State<_AbbonLoading> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;
  late int _counter = 0;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();

    _controller = _controller..repeat();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() => _counter = timer.tick % 4);
      },
    );
  }

  final style = GoogleFonts.sarabun(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2 * math.pi,
                        child: child,
                      );
                    },
                    child: Image.asset("assets/images/icons/world_white@3x.png", width: 40),
                  ),
                  const SizedBox(width: AppTheme.sizeM),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Text("Loading", style: style),
                        Text(
                          ".",
                          style: style.copyWith(
                            color: (_counter > 0) ? Colors.white : Colors.transparent,
                          ),
                        ),
                        Text(".",
                            style: style.copyWith(
                              color: (_counter > 1) ? Colors.white : Colors.transparent,
                            )),
                        Text(".",
                            style: style.copyWith(
                              color: (_counter > 2) ? Colors.white : Colors.transparent,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }
}
