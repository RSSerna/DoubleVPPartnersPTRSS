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
                    hint: AppStrings.firstNameHint,
                    icon: Icons.person,
                    validator: (value) => FormValidators.validateName(value),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  CustomFormField(
                    controller: _lastNameController,
                    label: AppStrings.lastNameLabel,
                    hint: AppStrings.lastNameHint,
                    icon: Icons.person_outline,
                    validator: (value) => FormValidators.validateName(
                      value,
                      fieldName: AppStrings.lastNameField,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(
                      _selectedDate == null
                          ? AppStrings.birthDateLabel
                          : '${AppStrings.selectDateLabel}${DateFormat(AppStrings.dateFormat).format(_selectedDate!)}',
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(AppStrings.continueButtonLabel),
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_selectedDate != null &&
                            !FormValidators.isAdult(_selectedDate!)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(AppStrings.mustBeAdultError),
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
                              content: Text(AppStrings.selectBirthDateError),
                            ),
                          );
                        }
                      },
                    ),
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
