import 'package:image_picker/image_picker.dart';

enum MenuEnums {
  contact,
  home,
  setting,
}

enum LangEnums {
  en,
  th,
}

enum ProcessType { create, update }

enum SearchType { all, search }

enum ImageType {
  camera,
  gallery,
}

enum FileType {
  asset,
  file,
  url,
}

enum DialogStatus { success, error, invalid, info }

extension MenuEnumsX on MenuEnums {
  String get describe {
    switch (this) {
      case MenuEnums.contact:
        return "contact";

      case MenuEnums.home:
        return "home";

      case MenuEnums.setting:
        return "setting";
    }
  }
}

extension LangEnumsX on LangEnums {
  String get describe {
    switch (this) {
      case LangEnums.en:
        return "en";

      case LangEnums.th:
        return "th";
    }
  }
}

extension ProcessTypeXCompare on ProcessType {
  bool get isCreate => this == ProcessType.create;
  bool get isUpdate => this == ProcessType.update;
}

extension SearchTypeX on SearchType {
  bool get isAll => this == SearchType.all;
  bool get isSearch => this == SearchType.search;
}

extension ImageTypeX on ImageType {
  bool get isCamera => this == ImageType.camera;
  bool get isGallery => this == ImageType.gallery;

  ImageSource get getSourceImageType =>
      this == ImageType.camera ? ImageSource.camera : ImageSource.gallery;
}

extension FileTypeX on FileType {
  bool get isAsset => this == FileType.asset;
  bool get isFile => this == FileType.file;
  bool get isUrl => this == FileType.url;
}
