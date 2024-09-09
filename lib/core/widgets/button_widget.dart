import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ButtonDialog extends StatelessWidget {
  const ButtonDialog({
    Key? key,
    required this.title,
    required this.onTap,
    this.isCancel = false,
  }) : super(key: key);

  final String title;
  final Function() onTap;
  final bool isCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppTheme.sizeL),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40.0,
          // width: 124.0,
          decoration: BoxDecoration(
            color: isCancel ? Colors.white : AppTheme.color.tertiaryColor,
            border: Border.all(
              color: isCancel ? AppTheme.color.secondaryColor.withOpacity(.4) : AppTheme.color.tertiaryColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Center(
            child: Text(
              title,
              style: AppTheme.font.mitrS14.copyWith(
                color: isCancel ? AppTheme.color.secondaryColor.withOpacity(.4) : AppTheme.color.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    this.onTap,
    this.title = 'ตกลง',
    required this.image,
  }) : super(key: key);

  final Function? onTap;
  final String? title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap != null ? onTap?.call() : () {};
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.color.primaryColor,
          borderRadius: BorderRadius.circular(
            AppTheme.sizeXL,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.sizeSS, vertical: AppTheme.sizeSS),
          child: Row(
            children: [
              Image.asset(
                image,
                width: 16,
                color: AppTheme.color.secondaryColor,
              ),
              Text(
                title ?? '',
                style: AppTheme.font.mitrS14.copyWith(
                  color: AppTheme.color.secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
