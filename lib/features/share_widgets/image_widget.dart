import 'dart:io';

import 'package:abbon_demo/core/enums/main_enums.dart';
import 'package:flutter/material.dart';

class ImageCircle extends StatelessWidget {
  const ImageCircle({
    Key? key,
    this.width = 150,
    this.height = 150,
    this.fileType = FileType.asset,
    this.path,
    this.file,
  }) : super(key: key);
  final double? width;
  final double? height;
  final FileType? fileType;
  final String? path;
  final File? file;

  @override
  Widget build(BuildContext context) {
    if (fileType == FileType.asset && path != null) {
      return ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(48),
          child: Image.asset(
            path!,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if (fileType == FileType.file && file != null) {
      return ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(48),
          child: Image.file(
            file!,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return ClipOval(
      child: SizedBox.fromSize(
        size: const Size.fromRadius(48),
        child: Image.network(
          path!,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
