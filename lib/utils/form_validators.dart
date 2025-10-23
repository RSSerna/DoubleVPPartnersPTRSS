class FormValidators {
  static String? validateName(String? value,
      {String fieldName = 'nombre', int minLength = 2}) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su $fieldName';
    }
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$').hasMatch(value)) {
      return 'El $fieldName solo debe contener letras';
    }
    if (value.length < minLength) {
      return 'El $fieldName debe tener al menos $minLength caracteres';
    }
    return null;
  }

  static String? validateLocationField(String? value,
      {String fieldName = 'campo', int minLength = 3}) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese el $fieldName';
    }
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$').hasMatch(value)) {
      return 'El $fieldName solo debe contener letras';
    }
    if (value.length < minLength) {
      return 'El $fieldName debe tener al menos $minLength caracteres';
    }
    return null;
  }

  static bool isAdult(DateTime birthDate) {
    final age = DateTime.now().difference(birthDate).inDays ~/ 365;
    return age >= 18;
  }
}
