import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/form_validators.dart';
import '../../user_management.dart';
import '../bloc/user_event.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.createUserTitle),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoaded) {
            // Navigate to address form using go_router
            context.push(AppRouter.addressForm);
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CustomFormField(
                    controller: _firstNameController,
                    label: AppStrings.firstNameLabel,
                    validator: (value) => FormValidators.validateName(value),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  CustomFormField(
                    controller: _lastNameController,
                    label: AppStrings.lastNameLabel,
                    validator: (value) => FormValidators.validateName(
                      value,
                      fieldName: 'apellido',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(
                      _selectedDate == null
                          ? 'Seleccionar fecha de nacimiento'
                          : 'Fecha: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedDate != null &&
                          !FormValidators.isAdult(_selectedDate!)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Debes ser mayor de 18 años'),
                          ),
                        );
                        return;
                      }

                      if (_formKey.currentState!.validate() &&
                          _selectedDate != null) {
                        context.read<UserBloc>().add(
                              CreateUserEvent(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                birthDate: _selectedDate!,
                              ),
                            );
                      } else if (_selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Por favor seleccione una fecha de nacimiento'),
                          ),
                        );
                      }
                    },
                    child: const Text('Continuar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
