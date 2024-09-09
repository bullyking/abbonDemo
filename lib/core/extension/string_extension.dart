// ignore: depend_on_referenced_packages
// ignore_for_file: depend_on_referenced_packages, duplicate_ignore

extension Check on String? {
  bool get isNullOrEmpty {
    return this == null ||
        (this != null && this!.isEmpty) ||
        (this != null && this!.contains("null"));
  }
}
