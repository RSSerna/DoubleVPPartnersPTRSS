import 'package:go_router/go_router.dart';

import '../../features/user_management/presentation/screens/address_form_screen.dart';
import '../../features/user_management/presentation/screens/user_details_screen.dart';
import '../../features/user_management/presentation/screens/user_form_screen.dart';
import '../constants/app_strings.dart';

class AppRouter {
  static const String userForm = AppStrings.userFormRoute;
  static const String userDetails = AppStrings.userDetailsRoute;
  static const String addressForm = AppStrings.addressFormRoute;

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: userForm,
        builder: (context, state) => const UserFormScreen(),
      ),
      GoRoute(
        path: userDetails,
        builder: (context, state) => const UserDetailsScreen(),
      ),
      GoRoute(
        path: addressForm,
        builder: (context, state) => const AddressFormScreen(),
      ),
    ],
  );
}
