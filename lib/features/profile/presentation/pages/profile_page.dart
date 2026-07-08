import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push(RouteNames.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 24),
            _buildMenuSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(30),
              child: Icon(
                Icons.person,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'User Name',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              'user@example.com',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                // TODO: Edit profile
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _buildMenuItem(
            context,
            'My Goals',
            Icons.flag_outlined,
            () {},
          ),
          _buildMenuItem(
            context,
            'Achievements',
            Icons.emoji_events_outlined,
            () {},
          ),
          _buildMenuItem(
            context,
            'Statistics',
            Icons.analytics_outlined,
            () => context.push(RouteNames.analytics),
          ),
          _buildMenuItem(
            context,
            'Export Data',
            Icons.download_outlined,
            () {},
          ),
          _buildMenuItem(
            context,
            'Help & Support',
            Icons.help_outline,
            () {},
          ),
          _buildMenuItem(
            context,
            'Sign Out',
            Icons.logout,
            () {
              // TODO: Sign out
            },
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive
            ? Theme.of(context).colorScheme.error
            : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive
              ? Theme.of(context).colorScheme.error
              : null,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
