import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:discipline_os/core/theme/app_theme.dart';
import 'package:discipline_os/core/router/app_router.dart';

void main() {
  testWidgets('App theme renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme(),
        home: const Scaffold(
          body: Center(child: Text('Test')),
        ),
      ),
    );
    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets('Dark theme renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme(),
        home: const Scaffold(
          body: Center(child: Text('Dark Test')),
        ),
      ),
    );
    expect(find.text('Dark Test'), findsOneWidget);
  });

  testWidgets('AMOLED theme renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.amoledTheme(),
        home: const Scaffold(
          body: Center(child: Text('AMOLED Test')),
        ),
      ),
    );
    expect(find.text('AMOLED Test'), findsOneWidget);
  });

  testWidgets('High contrast theme renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.highContrastTheme(),
        home: const Scaffold(
          body: Center(child: Text('High Contrast Test')),
        ),
      ),
    );
    expect(find.text('High Contrast Test'), findsOneWidget);
  });
}
