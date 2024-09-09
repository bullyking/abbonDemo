import 'package:abbon_demo/core/widgets/app_constate.dart';
import 'package:abbon_demo/core/widgets/input_validation.dart';
import 'package:formz/formz.dart';

enum LastNameFieldValidationError { invalid, require }

extension FirstNameFieldValidationErrorX on LastNameFieldValidationError {
  String? get describe {
    switch (this) {
      case LastNameFieldValidationError.invalid:
        return AppConstant.incorrectField;
      case LastNameFieldValidationError.require:
        return AppConstant.require;
    }
  }
}

class LastNameField extends FormzInput<String?, LastNameFieldValidationError>
    with InputValidationMixin {
  final bool isRequired;
  const LastNameField.pure({String? value, this.isRequired = true}) : super.pure(value);
  const LastNameField.dirty({String? value, this.isRequired = true}) : super.dirty(value);

  @override
  LastNameFieldValidationError? validator(String? value) {
    if ((value == null) || (value.isEmpty)) {
      return LastNameFieldValidationError.require;
    }
    return null;
  }
}
