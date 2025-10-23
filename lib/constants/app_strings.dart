class AppStrings {
  // App
  static const String appTitle = 'User Registration App';

  // Titles
  static const String createUserTitle = 'Crear Usuario';
  static const String addAddressTitle = 'Agregar Dirección';
  static const String userDetailsTitle = 'Detalles del Usuario';
  static const String viewDetailsButtonLabel = 'Ver Detalles';
  static const String continueButtonLabel = 'Continuar';
  static const String addAddressButtonLabel = 'Agregar Dirección';

  // Form Labels
  static const String firstNameLabel = 'Nombre';
  static const String lastNameLabel = 'Apellido';
  static const String birthDateLabel = 'Seleccionar fecha de nacimiento';
  static const String dateFormatLabel = 'Fecha de nacimiento: ';
  static const String countryLabel = 'País';
  static const String departmentLabel = 'Departamento';
  static const String municipalityLabel = 'Municipio';
  static const String addressesLabel = 'Direcciones:';

  // Validation Messages
  static const String enterNameError = 'Por favor ingrese su $fieldPlaceholder';
  static const String onlyLettersError =
      'El $fieldPlaceholder solo debe contener letras';
  static const String minLengthError =
      'El $fieldPlaceholder debe tener al menos $fieldPlaceholder2 caracteres';
  static const String selectBirthDateError =
      'Por favor seleccione una fecha de nacimiento';
  static const String mustBeAdultError = 'Debes ser mayor de 18 años';
  static const String userNotCreatedError = 'User not created yet';
  static const String addressAddedSuccess = 'Dirección agregada exitosamente';

  // Field Names (for validation messages)
  static const String firstNameField = 'nombre';
  static const String lastNameField = 'apellido';
  static const String countryField = 'país';
  static const String departmentField = 'departamento';
  static const String municipalityField = 'municipio';

  //Placeholders
  static const String fieldPlaceholder = '{field}';
  static const String fieldPlaceholder2 = '{field2}';

  // Formatting
  static const String dateFormat = 'dd/MM/yyyy';

  // Generic Field Labels
  static const String genericFieldLabel = 'campo';
}
