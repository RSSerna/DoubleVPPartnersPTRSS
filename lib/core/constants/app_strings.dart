class AppStrings {
  const AppStrings._();

  // App
  static const String appTitle = 'User Registration App';

  // Titles
  static const String createUserTitle = 'Crear Usuario';
  static const String addAddressTitle = 'Agregar Dirección';
  static const String userDetailsTitle = 'Detalles del Usuario';

  // Button Labels
  static const String viewDetailsButtonLabel = 'Ver Detalles';
  static const String continueButtonLabel = 'Continuar';
  static const String addAddressButtonLabel = 'Agregar Dirección';
  static const String saveButtonLabel = 'Guardar';
  static const String backButtonLabel = 'Volver';

  // Form Labels
  static const String firstNameLabel = 'Nombre';
  static const String lastNameLabel = 'Apellido';
  static const String birthDateLabel = 'Seleccionar fecha de nacimiento';
  static const String dateFormatLabel = 'Fecha de nacimiento: ';
  static const String countryLabel = 'País';
  static const String departmentLabel = 'Departamento';
  static const String municipalityLabel = 'Municipio';
  static const String addressesLabel = 'Direcciones:';
  static const String selectDateLabel = 'Fecha: ';

  // Hints
  static const String countryHint = 'Ingrese el país';
  static const String departmentHint = 'Ingrese el departamento';
  static const String municipalityHint = 'Ingrese el municipio';
  static const String firstNameHint = 'Ingrese su nombre';
  static const String lastNameHint = 'Ingrese su apellido';

  // Validation Messages
  static const String enterNameError = 'Por favor ingrese su $fieldPlaceholder';
  static const String onlyLettersError =
      'El $fieldPlaceholder solo debe contener letras';
  static const String minLengthError =
      'El $fieldPlaceholder debe tener al menos $fieldPlaceholder2 caracteres';
  static const String selectBirthDateError =
      'Por favor seleccione una fecha de nacimiento';
  static const String mustBeAdultError = 'Debes ser mayor de 18 años';
  static const String userNotCreatedError = 'Usuario no creado aún';
  static const String addressAddedSuccess = 'Dirección agregada exitosamente';
  static const String requiredFieldError = 'Este campo es requerido';
  static const String invalidFormatError = 'Formato inválido';

  // Field Names (for validation messages)
  static const String firstNameField = 'nombre';
  static const String lastNameField = 'apellido';
  static const String countryField = 'país';
  static const String departmentField = 'departamento';
  static const String municipalityField = 'municipio';

  // Error Messages
  static const String genericError = 'Ha ocurrido un error';
  static const String networkError = 'Error de conexión';
  static const String storageError = 'Error al guardar los datos';
  static const String loadError = 'Error al cargar los datos';
  static const String saveError = 'Error al guardar';
  static const String deleteError = 'Error al eliminar';
  static const String updateError = 'Error al actualizar';

  // Error Codes
  static const String validationErrorCode = 'VALIDATION_ERROR';
  static const String storageErrorCode = 'STORAGE_ERROR';
  static const String unexpectedErrorCode = 'UNEXPECTED_ERROR';
  static const String networkErrorCode = 'NETWORK_ERROR';
  static const String notFoundErrorCode = 'NOT_FOUND_ERROR';
  static const String authErrorCode = 'AUTH_ERROR';

  // Exception Messages
  static const String validationExceptionMessage = 'Error de validación';
  static const String storageExceptionMessage = 'Error de almacenamiento';
  static const String unexpectedExceptionMessage = 'Error inesperado';
  static const String networkExceptionMessage = 'Error de red';
  static const String notFoundExceptionMessage = 'Recurso no encontrado';
  static const String authExceptionMessage = 'Error de autenticación';

  // Success Messages
  static const String saveSuccess = 'Guardado exitosamente';
  static const String updateSuccess = 'Actualizado exitosamente';
  static const String deleteSuccess = 'Eliminado exitosamente';
  static const String createSuccess = 'Creado exitosamente';

  // Navigation
  static const String cancelLabel = 'Cancelar';
  static const String confirmLabel = 'Confirmar';
  static const String closeLabel = 'Cerrar';

  // Placeholders
  static const String fieldPlaceholder = '{field}';
  static const String fieldPlaceholder2 = '{field2}';

  // Formatting
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';

  // Routes (for go_router)
  static const String userFormRoute = '/';
  static const String userDetailsRoute = '/user-details';
  static const String addressFormRoute = '/address-form';

  // Generic Field Labels
  static const String genericFieldLabel = 'campo';
  static const String nameFieldLabel = 'nombre';
  static const String emailFieldLabel = 'correo electrónico';
  static const String phoneFieldLabel = 'teléfono';
  static const String addressFieldLabel = 'dirección';
}
