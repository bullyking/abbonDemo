import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:abbon_demo/core/models/home/profile.dart';
import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:abbon_demo/features/home/bloc/home_bloc.dart';
import 'package:abbon_demo/features/home/widgets/profile_item.dart';
import 'package:abbon_demo/features/share_widgets/image_widget.dart';
import 'package:abbon_demo/features/share_widgets/modal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({
    Key? key,
    this.profile,
  }) : super(key: key);
  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppTheme.sizeXXXL),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.sizeSS),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => ModalHandleProfileImage(
                    takePicture: () {
                      context.read<HomeBloc>().add(SelectOrTakeImageEvent(
                          imageType: ImageType.camera,
                          onSuccess: () {
                            Navigator.pop(context);
                          }));
                    },
                    selectImage: () {
                      context.read<HomeBloc>().add(SelectOrTakeImageEvent(
                          imageType: ImageType.gallery,
                          onSuccess: () {
                            Navigator.pop(context);
                          }));
                    },
                    profile: profile,
                  ),
                );
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/images/icons/edit.png",
                      width: 15,
                      color: AppTheme.color.secondaryColor,
                    ),
                    Text(
                      '${AppLocalizations.of(context)?.editProfileImage}',
                      style: AppTheme.font.mitrS16.copyWith(
                        color: AppTheme.color.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            LayoutBuilder(
              builder: ((context, constraints) {
                if (profile?.imageFile != null) {
                  return ImageCircle(
                    width: 220,
                    height: 220,
                    file: profile?.imageFile,
                    fileType: FileType.file,
                  );
                }

                return ImageCircle(
                  width: 220,
                  height: 220,
                  path: profile?.image,
                  fileType: FileType.asset,
                );
              }),
            ),
            const SizedBox(
              height: AppTheme.sizeM,
            ),
            Padding(
                padding: const EdgeInsets.all(AppTheme.sizeSS),
                child: ProfileItem(
                  hasIcon: false,
                  icon: Icon(
                    Icons.person_2_outlined,
                    color: AppTheme.color.secondaryColor,
                  ),
                  text: profile?.fullname,
                )),
            Padding(
                padding: const EdgeInsets.all(AppTheme.sizeSS),
                child: ProfileItem(
                  onTap: () async {
                    final email = Uri(
                      scheme: 'mailto',
                      path: profile?.email,
                      query: 'subject=Hello&body=Test',
                    );
                    if (await canLaunchUrl(email)) {
                      launchUrl(email);
                    }
                  },
                  icon: Icon(
                    Icons.email_outlined,
                    color: AppTheme.color.secondaryColor,
                  ),
                  text: profile?.email,
                )),
            Padding(
                padding: const EdgeInsets.all(AppTheme.sizeSS),
                child: ProfileItem(
                  onTap: () async {
                    await launchUrlString('tel://${profile?.phoneNumber}');
                  },
                  icon: Icon(
                    Icons.phone_outlined,
                    color: AppTheme.color.secondaryColor,
                  ),
                  text: profile?.phoneNumber,
                )),
            Padding(
                padding: const EdgeInsets.all(AppTheme.sizeSS),
                child: ProfileItem(
                  onTap: () async {
                    await launchUrlString(
                      profile?.lineLink ?? '',
                    );
                  },
                  icon: Icon(
                    Icons.contacts_outlined,
                    color: AppTheme.color.secondaryColor,
                  ),
                  text: profile?.lineId,
                )),
            Padding(
                padding: const EdgeInsets.all(AppTheme.sizeSS),
                child: ProfileItem(
                  onTap: () {
                    context.read<HomeBloc>().add(OpenLocationEvent(callback: () {
                      launchUrlString(
                        profile?.locationLink ?? '',
                      );
                    }));
                  },
                  icon: Icon(
                    Icons.location_pin,
                    color: AppTheme.color.secondaryColor,
                  ),
                  text: '${profile?.location}',
                )),
          ],
        ),
      ),
    );
  }
}
