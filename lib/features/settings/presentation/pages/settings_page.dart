import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/enums/theme_mode.dart';
import '../../../../shared/enums/ai_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onTap: () => _showThemeDialog(context),
              ),
              ListTile(
                leading: const Icon(Icons.text_fields),
                title: const Text('Font'),
                subtitle: const Text('Inter'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Navigate to font settings
                },
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
                  // TODO: Toggle notifications
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.do_not_disturb_on_outlined),
                title: const Text('Smart Notifications'),
                subtitle: const Text('AI-optimized reminder timing'),
                value: true,
                onChanged: (value) {
                  // TODO: Toggle smart notifications
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
                  // TODO: Toggle biometric
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.lock_outline),
                title: const Text('PIN Lock'),
                value: false,
                onChanged: (value) {
                  // TODO: Toggle PIN lock
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
                  // TODO: Open privacy policy
                },
              ),
              ListTile(
                leading: const Icon(Icons.gavel_outlined),
                title: const Text('Terms of Service'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Open terms
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

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppThemeMode.values.map((mode) {
            final isSelected = mode == AppThemeMode.system;
            return ListTile(
              title: Text(mode.label),
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
}
