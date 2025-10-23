import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/presentation/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/form_validators.dart';
import '../../domain/entities/address_entity.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';
import '../widgets/custom_form_field.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
          tooltip: AppStrings.backButtonLabel,
        ),
        title: Text(AppStrings.addAddressTitle),
        actions: [
          TextButton(
            onPressed: () {
              context.go(AppRouter.userDetails);
            },
            child: Text(AppStrings.viewDetailsButtonLabel),
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
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CustomFormField(
                            controller: _countryController,
                            label: AppStrings.countryLabel,
                            hint: AppStrings.countryHint,
                            icon: Icons.public,
                            validator: (value) =>
                                FormValidators.validateLocationField(
                              value,
                              fieldName: AppStrings.countryField,
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 12),
                          CustomFormField(
                            controller: _departmentController,
                            label: AppStrings.departmentLabel,
                            hint: AppStrings.departmentHint,
                            icon: Icons.map,
                            validator: (value) =>
                                FormValidators.validateLocationField(
                              value,
                              fieldName: AppStrings.departmentField,
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 12),
                          CustomFormField(
                            controller: _municipalityController,
                            label: AppStrings.municipalityLabel,
                            hint: AppStrings.municipalityHint,
                            icon: Icons.location_city,
                            validator: (value) =>
                                FormValidators.validateLocationField(
                              value,
                              fieldName: AppStrings.municipalityField,
                            ),
                            textInputAction: TextInputAction.done,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.add_location),
                      label: Text(AppStrings.addAddressButtonLabel),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final address = AddressEntity(
                            country: _countryController.text.trim(),
                            department: _departmentController.text.trim(),
                            municipality: _municipalityController.text.trim(),
                          );
                          context
                              .read<UserBloc>()
                              .add(AddAddressEvent(address: address));

                          // Clear the form
                          _countryController.clear();
                          _departmentController.clear();
                          _municipalityController.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(AppStrings.addressAddedSuccess),
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
