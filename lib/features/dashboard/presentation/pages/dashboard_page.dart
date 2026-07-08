import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../providers/dashboard_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);

    return Scaffold(
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ref.read(dashboardProvider.notifier).refresh(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeHeader(context, state),
                    const SizedBox(height: 16),
                    _buildAISummary(context, state),
                    const SizedBox(height: 16),
                    _buildScoresSection(context, state),
                    const SizedBox(height: 16),
                    _buildQuickActions(context),
                    const SizedBox(height: 16),
                    _buildTodayTasks(context, state),
                    const SizedBox(height: 16),
                    _buildTodayHabits(context, state),
                    const SizedBox(height: 16),
                    _buildHealthSection(context, state),
                    const SizedBox(height: 16),
                    _buildQuoteCard(context, state),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildWelcomeHeader(BuildContext context, DashboardState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good ${_getTimeOfDay()}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 4),
        Text(
          'Here\'s your daily overview',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          ),
        ),
      ],
    );
  }

  Widget _buildAISummary(BuildContext context, DashboardState state) {
    if (state.data.aiSummary == null) return const SizedBox.shrink();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.psychology,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                state.data.aiSummary!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoresSection(BuildContext context, DashboardState state) {
    return Row(
      children: [
        Expanded(
          child: _buildScoreCard(
            context,
            'Discipline',
            state.data.disciplineScore,
            Icons.star_outline,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildScoreCard(
            context,
            'Productivity',
            state.data.productivityScore,
            Icons.speed,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildScoreCard(
            context,
            'Health',
            state.data.healthScore,
            Icons.favorite_outline,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCard(
    BuildContext context,
    String label,
    double score,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              score.toInt().toString(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildActionButton(
              context,
              'New Task',
              Icons.add_task,
              () => context.push(RouteNames.createTask),
            ),
            _buildActionButton(
              context,
              'Start Focus',
              Icons.timer,
              () => context.push(RouteNames.focus),
            ),
            _buildActionButton(
              context,
              'Ask AI',
              Icons.psychology,
              () => context.push(RouteNames.ai),
            ),
            _buildActionButton(
              context,
              'Log Water',
              Icons.water_drop,
              () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(30),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildTodayTasks(BuildContext context, DashboardState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Tasks',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  onPressed: () => context.push(RouteNames.tasks),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: state.data.todayTasks == 0
                  ? 0
                  : state.data.completedTasks / state.data.todayTasks,
            ),
            const SizedBox(height: 8),
            Text(
              '${state.data.completedTasks} of ${state.data.todayTasks} completed',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayHabits(BuildContext context, DashboardState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Habits',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  onPressed: () => context.push(RouteNames.habits),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: state.data.todayHabits == 0
                  ? 0
                  : state.data.completedHabits / state.data.todayHabits,
            ),
            const SizedBox(height: 8),
            Text(
              '${state.data.completedHabits} of ${state.data.todayHabits} completed',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthSection(BuildContext context, DashboardState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Health',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHealthMetric(
                  context,
                  'Water',
                  '${state.data.waterIntake}ml',
                  Icons.water_drop,
                ),
                _buildHealthMetric(
                  context,
                  'Focus',
                  '${state.data.totalFocusMinutes}m',
                  Icons.timer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthMetric(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.titleSmall),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildQuoteCard(BuildContext context, DashboardState state) {
    if (state.data.quoteOfTheDay == null) return const SizedBox.shrink();
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          '"${state.data.quoteOfTheDay}"',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  String _getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }
}
