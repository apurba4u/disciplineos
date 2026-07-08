import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/theme/font_provider.dart';
import '../../../../shared/enums/ai_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontState = ref.watch(fontProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            title: 'Appearance',
            children: [
              ListTile(
                leading: const Icon(Icons.palette_outlined),
                title: const Text('Theme'),
                subtitle: const Text('System Default'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showThemeDialog(context, ref),
              ),
              ListTile(
                leading: const Icon(Icons.text_fields),
                title: const Text('Font'),
                subtitle: Text(fontState.fontFamily.label),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showFontDialog(context, ref),
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'AI',
            children: [
              ListTile(
                leading: const Icon(Icons.psychology_outlined),
                title: const Text('AI Provider'),
                subtitle: const Text('Gemini'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showAIProviderDialog(context),
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Notifications',
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.notifications_outlined),
                title: const Text('Enable Notifications'),
                value: true,
                onChanged: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Notifications ${value ? "enabled" : "disabled"}')),
                  );
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.do_not_disturb_on_outlined),
                title: const Text('Smart Notifications'),
                subtitle: const Text('AI-optimized reminder timing'),
                value: true,
                onChanged: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Smart notifications ${value ? "enabled" : "disabled"}')),
                  );
                },
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Security',
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.fingerprint),
                title: const Text('Biometric Login'),
                value: false,
                onChanged: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Biometric ${value ? "enabled" : "disabled"}')),
                  );
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.lock_outline),
                title: const Text('PIN Lock'),
                value: false,
                onChanged: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('PIN lock ${value ? "enabled" : "disabled"}')),
                  );
                },
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'About',
            children: [
              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Version'),
                subtitle: Text('1.0.0'),
              ),
              ListTile(
                leading: const Icon(Icons.description_outlined),
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Privacy policy coming soon')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.gavel_outlined),
                title: const Text('Terms of Service'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Terms of service coming soon')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    final themeState = ref.read(themeProvider);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(context, 'Light', ThemeType.light, themeState, ref),
            _buildThemeOption(context, 'Dark', ThemeType.dark, themeState, ref),
            _buildThemeOption(context, 'AMOLED', ThemeType.amoled, themeState, ref),
            _buildThemeOption(context, 'High Contrast', ThemeType.highContrast, themeState, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String title,
    ThemeType themeType,
    ThemeState currentTheme,
    WidgetRef ref,
  ) {
    final isSelected = currentTheme.themeType == themeType;
    return ListTile(
      title: Text(title),
      leading: Icon(
        isSelected ? Icons.check_circle : Icons.circle_outlined,
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
      onTap: () {
        ref.read(themeProvider.notifier).setTheme(themeType);
        Navigator.pop(context);
      },
    );
  }

  void _showAIProviderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select AI Provider'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AIProviderType.values.map((provider) {
            final isSelected = provider == AIProviderType.gemini;
            return ListTile(
              title: Text(provider.label),
              leading: Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected ? Theme.of(context).colorScheme.primary : null,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showFontDialog(BuildContext context, WidgetRef ref) {
    final fontState = ref.read(fontProvider);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Font'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: FontFamily.values.map((font) {
              final isSelected = fontState.fontFamily == font;
              return ListTile(
                title: Text(
                  font.label,
                  style: TextStyle(fontFamily: font.fontFamily),
                ),
                leading: Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? Theme.of(context).colorScheme.primary : null,
                ),
                onTap: () {
                  ref.read(fontProvider.notifier).setFontFamily(font);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
