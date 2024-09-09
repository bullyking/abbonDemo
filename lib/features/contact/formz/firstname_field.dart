import 'package:abbon_demo/core/widgets/app_constate.dart';
import 'package:abbon_demo/core/widgets/input_validation.dart';
import 'package:formz/formz.dart';

enum FirstNameFieldValidationError { invalid, require }

extension FirstNameFieldValidationErrorX on FirstNameFieldValidationError {
  String? get describe {
    switch (this) {
      case FirstNameFieldValidationError.invalid:
        return AppConstant.incorrectField;
      case FirstNameFieldValidationError.require:
        return AppConstant.require;
    }
  }
}

class FirstNameField extends FormzInput<String?, FirstNameFieldValidationError> with InputValidationMixin {
  final bool isRequired;
  const FirstNameField.pure({String? value, this.isRequired = true}) : super.pure(value);
  const FirstNameField.dirty({String? value, this.isRequired = true}) : super.dirty(value);

  @override
  FirstNameFieldValidationError? validator(String? value) {
    if ((value == null) || (value.isEmpty)) {
      return FirstNameFieldValidationError.require;
    }
    return null;
  }
}
