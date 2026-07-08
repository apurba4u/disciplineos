import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/analytics_data.dart';
import '../../domain/usecases/get_analytics_usecase.dart';
import '../providers/analytics_provider.dart';

class AnalyticsPage extends ConsumerWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(analyticsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          PopupMenuButton<AnalyticsPeriod>(
            icon: const Icon(Icons.calendar_today),
            onSelected: (period) {
              ref.read(analyticsProvider.notifier).setPeriod(period);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: AnalyticsPeriod.daily,
                child: Text('Daily'),
              ),
              const PopupMenuItem(
                value: AnalyticsPeriod.weekly,
                child: Text('Weekly'),
              ),
              const PopupMenuItem(
                value: AnalyticsPeriod.monthly,
                child: Text('Monthly'),
              ),
            ],
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.data == null
              ? const Center(child: Text('No data available'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildScoresSection(context, state.data!),
                      const SizedBox(height: 24),
                      _buildStatsSection(context, state.data!),
                    ],
                  ),
                ),
    );
  }

  Widget _buildScoresSection(BuildContext context, AnalyticsData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Scores',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildScoreCard(
                context,
                'Discipline',
                data.disciplineScore,
                Icons.star,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildScoreCard(
                context,
                'Productivity',
                data.productivityScore,
                Icons.speed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildScoreCard(
                context,
                'Health',
                data.healthScore,
                Icons.favorite,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildScoreCard(
                context,
                'Focus',
                data.focusScore,
                Icons.timer,
              ),
            ),
          ],
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              score.toInt().toString(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, AnalyticsData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistics',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildStatRow(
                  context,
                  'Tasks Completed',
                  '${data.completedTasks} / ${data.totalTasks}',
                  Icons.task_alt,
                ),
                const Divider(),
                _buildStatRow(
                  context,
                  'Habits Completed',
                  '${data.completedHabits} / ${data.totalHabits}',
                  Icons.check_circle,
                ),
                const Divider(),
                _buildStatRow(
                  context,
                  'Focus Time',
                  '${data.totalFocusMinutes} min',
                  Icons.timer,
                ),
                const Divider(),
                _buildStatRow(
                  context,
                  'Water Intake',
                  '${data.totalWaterIntake} ml',
                  Icons.water_drop,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(child: Text(label)),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
