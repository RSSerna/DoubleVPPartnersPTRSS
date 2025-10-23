import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart';
import 'core/di/dependency_injection.dart' as di;
import 'features/user_management/user_management.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserBloc>(),
      child: MaterialApp.router(
        title: AppStrings.appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
