import 'package:abbon_demo/features/contact/formz/age_field.dart';
import 'package:abbon_demo/features/contact/formz/firstname_field.dart';
import 'package:abbon_demo/features/contact/formz/lastname_field.dart';
import 'package:formz/formz.dart';

class ContactFormState with FormzMixin {
  final FirstNameField firstNameField;
  final LastNameField lastNameField;
  final AgeField ageField;

  const ContactFormState.pure({
    this.firstNameField = const FirstNameField.pure(),
    this.lastNameField = const LastNameField.pure(),
    this.ageField = const AgeField.pure(),
  });

  ContactFormState({
    required this.firstNameField,
    required this.lastNameField,
    required this.ageField,
  });

  bool get isFormValid => FormzStatus.valid == status;

  ContactFormState copyWith({
    FirstNameField? firstNameField,
    LastNameField? lastNameField,
    AgeField? ageField,
  }) {
    return ContactFormState(
      firstNameField: firstNameField ?? this.firstNameField,
      lastNameField: lastNameField ?? this.lastNameField,
      ageField: ageField ?? this.ageField,
    );
  }

  @override
  List<FormzInput> get inputs => [firstNameField, lastNameField, ageField];
}
