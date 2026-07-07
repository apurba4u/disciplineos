import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Login')),
        ),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Register')),
        ),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Forgot Password')),
        ),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Onboarding')),
        ),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.dashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Scaffold(body: Center(child: Text('Dashboard'))),
            ),
          ),
          GoRoute(
            path: RouteNames.tasks,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Scaffold(body: Center(child: Text('Tasks'))),
            ),
          ),
          GoRoute(
            path: RouteNames.ai,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Scaffold(body: Center(child: Text('AI Coach'))),
            ),
          ),
          GoRoute(
            path: RouteNames.analytics,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Scaffold(body: Center(child: Text('Analytics'))),
            ),
          ),
          GoRoute(
            path: RouteNames.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Scaffold(body: Center(child: Text('Profile'))),
            ),
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.taskDetails,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Task Details')),
        ),
      ),
      GoRoute(
        path: RouteNames.createTask,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Create Task')),
        ),
      ),
      GoRoute(
        path: RouteNames.habitDetails,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Habit Details')),
        ),
      ),
      GoRoute(
        path: RouteNames.createHabit,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Create Habit')),
        ),
      ),
      GoRoute(
        path: RouteNames.goalDetails,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Goal Details')),
        ),
      ),
      GoRoute(
        path: RouteNames.createGoal,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Create Goal')),
        ),
      ),
      GoRoute(
        path: RouteNames.focus,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Focus Mode')),
        ),
      ),
      GoRoute(
        path: RouteNames.calendar,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Calendar')),
        ),
      ),
      GoRoute(
        path: RouteNames.settings,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Settings')),
        ),
      ),
      GoRoute(
        path: RouteNames.notifications,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Notifications')),
        ),
      ),
    ],
  );
});

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            activeIcon: Icon(Icons.task),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology_outlined),
            activeIcon: Icon(Icons.psychology),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/tasks')) return 1;
    if (location.startsWith('/ai')) return 2;
    if (location.startsWith('/analytics')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(RouteNames.dashboard);
      case 1:
        context.go(RouteNames.tasks);
      case 2:
        context.go(RouteNames.ai);
      case 3:
        context.go(RouteNames.analytics);
      case 4:
        context.go(RouteNames.profile);
    }
  }
}
