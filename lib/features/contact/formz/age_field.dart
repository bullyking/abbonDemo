import 'package:abbon_demo/core/widgets/app_constate.dart';
import 'package:abbon_demo/core/widgets/input_validation.dart';
import 'package:formz/formz.dart';

enum AgeFieldValidationError { invalid, require }

extension FirstNameFieldValidationErrorX on AgeFieldValidationError {
  String? get describe {
    switch (this) {
      case AgeFieldValidationError.invalid:
        return AppConstant.incorrectField;
      case AgeFieldValidationError.require:
        return AppConstant.require;
    }
  }
}

class AgeField extends FormzInput<String?, AgeFieldValidationError> with InputValidationMixin {
  final bool isRequired;
  final int age;
  const AgeField.pure({String? value, this.isRequired = true, this.age = 1}) : super.pure(value);
  const AgeField.dirty({String? value, this.isRequired = true, this.age = 1}) : super.dirty(value);

  @override
  AgeFieldValidationError? validator(String? value) {
    if ((value == null) || (value.isEmpty)) {
      return AgeFieldValidationError.require;
    } else if (int.parse(value) < 1) {
      return AgeFieldValidationError.invalid;
    }
    return null;
  }
}
