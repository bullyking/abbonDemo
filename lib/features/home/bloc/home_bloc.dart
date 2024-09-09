import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:abbon_demo/core/models/home/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _picker = ImagePicker();

  HomeBloc() : super(const HomeState.init()) {
    on<FetchProfileEvent>(_fetchProfileToState);
    on<OpenLocationEvent>(_openLocationToState);
    on<SelectOrTakeImageEvent>(_selectorTakeImageToState);
  }

  FutureOr<void> _fetchProfileToState(FetchProfileEvent event, Emitter emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final profile = Profile.init();
      emit(state.copyWith(status: HomeStatus.success, profile: profile));

      if (event.onSuccess != null) event.onSuccess?.call();
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, errorMsg: '$e'));
    }
  }

  FutureOr<void> _openLocationToState(OpenLocationEvent event, emit) async {
    try {
      const Permission locationPermission = Permission.location;
      bool locationStatus = false;
      bool isPermanentlyDenied = await locationPermission.isPermanentlyDenied;
      debugPrint('isPermanentlyDenied => $isPermanentlyDenied');
      if (isPermanentlyDenied) {
        await openAppSettings();
      } else {
        event.callback?.call();
      }
    } catch (e) {
      debugPrint('error OpenLocationEvent => $e');
    }
  }

  FutureOr<void> _selectorTakeImageToState(SelectOrTakeImageEvent event, emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      XFile? image = await _picker.pickImage(source: event.imageType.getSourceImageType);
      File? tempCoverImgFile = await getTempFile(imagefile: image);

      emit(state.copyWith(
        status: HomeStatus.success,
        profile: state.profile?.copyWith(imageFile: tempCoverImgFile),
      ));

      if (event.onSuccess != null) event.onSuccess?.call();
    } catch (e) {
      debugPrint('error SelectOrTakeImageEvent => $e');
      emit(state.copyWith(status: HomeStatus.error, errorMsg: '$e'));
    }
  }

  FutureOr<File?> getTempFile({XFile? imagefile}) async {
    if (imagefile != null) {
      Uint8List byteData = File(imagefile.path).readAsBytesSync();
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/image_${DateTime.now().minute}_${DateTime.now().second}.png').create();
      file.writeAsBytesSync(byteData);
      return file;
    }
    return null;
  }
}
