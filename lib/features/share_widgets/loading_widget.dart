import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.hasBgColor = true}) : super(key: key);
  final bool? hasBgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: hasBgColor == true ? AppTheme.color.backdrop.withOpacity(0.2) : Colors.transparent,
        alignment: Alignment.center,
        child: Center(
          child: CurvedCircularProgressIndicator(
            strokeWidth: 4,
            backgroundColor: AppTheme.color.secondaryColor,
            color: AppTheme.color.tertiaryColor,
          ),
        ),
      ),
    );
  }
}
