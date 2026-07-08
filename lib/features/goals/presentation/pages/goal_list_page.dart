import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/enums/goal_status.dart';
import '../../domain/entities/goal.dart';
import '../providers/goal_provider.dart';

class GoalListPage extends ConsumerWidget {
  const GoalListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(goalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.goals.isEmpty
              ? _buildEmptyState(context)
              : _buildGoalList(context, ref, state),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to create goal page
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flag_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withAlpha(50),
          ),
          const SizedBox(height: 16),
          Text(
            'No goals yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Set your first goal to start tracking progress',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalList(
    BuildContext context,
    WidgetRef ref,
    GoalState state,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.goals.length,
      itemBuilder: (context, index) {
        final goal = state.goals[index];
        return _GoalCard(goal: goal);
      },
    );
  }
}

class _GoalCard extends StatelessWidget {
  final Goal goal;

  const _GoalCard({required this.goal});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.flag,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    goal.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                _buildStatusChip(context, goal.status),
              ],
            ),
            if (goal.description != null) ...[
              const SizedBox(height: 8),
              Text(
                goal.description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  '${goal.category.label}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                if (goal.targetDate != null)
                  Text(
                    'Target: ${goal.targetDate.toString().split(' ')[0]}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: goal.progress / 100,
            ),
            const SizedBox(height: 4),
            Text(
              '${goal.progress}% complete',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, GoalStatus status) {
    Color color;
    switch (status) {
      case GoalStatus.notStarted:
        color = Colors.grey;
        break;
      case GoalStatus.active:
        color = Colors.green;
        break;
      case GoalStatus.paused:
        color = Colors.orange;
        break;
      case GoalStatus.completed:
        color = Colors.blue;
        break;
      case GoalStatus.cancelled:
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
