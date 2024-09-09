import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:abbon_demo/core/models/home/profile.dart';
import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:abbon_demo/core/widgets/button_widget.dart';
import 'package:abbon_demo/features/share_widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModalHandleProfileImage extends StatelessWidget {
  const ModalHandleProfileImage({
    Key? key,
    this.profile,
    required this.takePicture,
    required this.selectImage,
  }) : super(key: key);

  final Profile? profile;
  final Function takePicture;
  final Function selectImage;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.sizeM),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: SizedBox(
        width: 348.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.sizeL,
            vertical: AppTheme.sizeL * 2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  '${AppLocalizations.of(context)?.selectImageType}',
                  style: AppTheme.font.mitrS20,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppTheme.sizeL),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.sizeL),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: AppTheme.sizeS),
                    LayoutBuilder(
                      builder: ((context, constraints) {
                        if (profile?.imageFile != null) {
                          return ImageCircle(
                            file: profile?.imageFile,
                            fileType: FileType.file,
                          );
                        }

                        return ImageCircle(
                          path: profile?.image,
                          fileType: FileType.asset,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonDialog(
                      title: '${AppLocalizations.of(context)?.takePhoto}',
                      onTap: () {
                        takePicture.call();
                      },
                      isCancel: true,
                    ),
                  ),
                  const SizedBox(width: AppTheme.sizeL),
                  Expanded(
                    child: ButtonDialog(
                      title: '${AppLocalizations.of(context)?.selectFromGallery}',
                      onTap: () {
                        selectImage.call();
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
