import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/services/app_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await AppService().initialize();

  runApp(const ProviderScope(child: DisciplineOSApp()));
}

class DisciplineOSApp extends ConsumerWidget {
  const DisciplineOSApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeState = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Discipline OS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(accentColor: themeState.accentColor),
      darkTheme: AppTheme.darkTheme(accentColor: themeState.accentColor),
      themeMode: themeState.themeMode,
      routerConfig: router,
    );
  }
}
