import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user_bloc.dart';
import '../blocs/user_event.dart';
import '../blocs/user_state.dart';
import '../models/address.dart';
import '../utils/form_validators.dart';
import '../widgets/custom_form_field.dart';
import 'user_details_screen.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({super.key});

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _countryController = TextEditingController();
  final _departmentController = TextEditingController();
  final _municipalityController = TextEditingController();

  @override
  void dispose() {
    _countryController.dispose();
    _departmentController.dispose();
    _municipalityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Dirección'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserDetailsScreen(),
                ),
              );
            },
            child: const Text('Ver Detalles'),
          ),
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
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
                    controller: _countryController,
                    label: 'País',
                    validator: (value) => FormValidators.validateLocationField(
                      value,
                      fieldName: 'país',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  CustomFormField(
                    controller: _departmentController,
                    label: 'Departamento',
                    validator: (value) => FormValidators.validateLocationField(
                      value,
                      fieldName: 'departamento',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  CustomFormField(
                    controller: _municipalityController,
                    label: 'Municipio',
                    validator: (value) => FormValidators.validateLocationField(
                      value,
                      fieldName: 'municipio',
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final address = Address(
                          country: _countryController.text,
                          department: _departmentController.text,
                          municipality: _municipalityController.text,
                        );
                        context
                            .read<UserBloc>()
                            .add(AddAddress(address: address));

                        // Clear the form
                        _countryController.clear();
                        _departmentController.clear();
                        _municipalityController.clear();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Dirección agregada exitosamente'),
                          ),
                        );
                      }
                    },
                    child: const Text('Agregar Dirección'),
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
