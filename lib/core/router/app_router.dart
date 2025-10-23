import 'package:go_router/go_router.dart';

import '../../features/user_management/presentation/screens/address_form_screen.dart';
import '../../features/user_management/presentation/screens/user_details_screen.dart';
import '../../features/user_management/presentation/screens/user_form_screen.dart';

class AppRouter {
  static const String userForm = '/';
  static const String userDetails = '/user-details';
  static const String addressForm = '/address-form';

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
