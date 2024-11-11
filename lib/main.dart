import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtest/core/theme.dart';
import 'package:riverpodtest/core/user_preferences/user_preferences.dart';
import 'package:riverpodtest/presentation/home/home_page.dart';
import 'package:riverpodtest/presentation/signup_page.dart';
import 'package:riverpodtest/presentation/viewmodel/auth_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(userPreferencesProvider).init();
  //We can also create a new provider for userModel
  await container.read(authViewModelProvider.notifier).getInitialData();
  //This is for without initiation of preferences or anything else
  //runApp(const ProviderScope(child: MyApp()));
  //It is use full like once we want to check user is login or not, navigation
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.read(userPreferencesProvider).getToken();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      home: HomePage(),
    );
  }
}
