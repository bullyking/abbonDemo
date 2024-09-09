import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.icon,
    this.hasIcon = true,
    this.text,
    this.onTap,
  }) : super(key: key);

  final Icon icon;
  final bool? hasIcon;
  final String? text;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null
          ? onTap?.call()
          : {
              debugPrint('do nothing'),
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.sizeM, vertical: AppTheme.sizeS),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.color.tertiaryColor.withOpacity(.1),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    icon,
                    const SizedBox(width: AppTheme.sizeM / 2),
                    Text(
                      '$text',
                      style: AppTheme.font.mitrS16.copyWith(color: AppTheme.color.tertiaryColor.withOpacity(.6)),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: hasIcon == true,
              child: Image.asset(
                "assets/images/icons/chevron_right.png",
                width: 15,
                color: AppTheme.color.tertiaryColor.withOpacity(.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
