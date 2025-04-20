import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_three/features/auth/auth_di.dart';
import 'package:test_three/features/notification/notification_di.dart';
import 'package:test_three/features/payment/payment_di.dart';

final getIt = GetIt.instance;

Future<void> initAppDependencies() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  // Register feature-specific dependencies
  initAuthDependencies();
  initPaymentDependencies();
  initNotificationDependencies();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
