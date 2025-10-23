import '../constants/app_strings.dart';

class FormValidators {
  static String? validateName(String? value,
      {String fieldName = AppStrings.firstNameField, int minLength = 2}) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterNameError
          .replaceAll(AppStrings.fieldPlaceholder, fieldName);
    }
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$').hasMatch(value)) {
      return AppStrings.onlyLettersError
          .replaceAll(AppStrings.fieldPlaceholder, fieldName);
    }
    if (value.length < minLength) {
      return AppStrings.minLengthError
          .replaceAll(AppStrings.fieldPlaceholder, fieldName)
          .replaceAll(AppStrings.fieldPlaceholder2, minLength.toString());
    }
    return null;
  }

  static String? validateLocationField(String? value,
      {String fieldName = AppStrings.genericFieldLabel, int minLength = 3}) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterNameError
          .replaceAll(AppStrings.fieldPlaceholder, fieldName);
    }
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$').hasMatch(value)) {
      return AppStrings.onlyLettersError
          .replaceAll(AppStrings.fieldPlaceholder, fieldName);
    }
    if (value.length < minLength) {
      return AppStrings.minLengthError
          .replaceAll(AppStrings.fieldPlaceholder, fieldName)
          .replaceAll(AppStrings.fieldPlaceholder2, minLength.toString());
    }
    return null;
  }

  static bool isAdult(DateTime birthDate) {
    final age = DateTime.now().difference(birthDate).inDays ~/ 365;
    return age >= 18;
  }
}
