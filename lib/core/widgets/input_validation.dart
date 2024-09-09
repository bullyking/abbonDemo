mixin InputValidationMixin {
  bool isEmptyValid(dynamic value) {
    if (value == null) {
      return false;
    } else if (value.runtimeType == String) {
      return value.isEmpty ? false : true;
    }
    return true;
  }
}
