import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../domain/entities/task.dart';
import '../../../../shared/enums/task_priority.dart';
import '../../../../shared/enums/task_status.dart';
import '../providers/task_provider.dart';

class TaskListPage extends ConsumerWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, ref),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.tasks.isEmpty
              ? _buildEmptyState(context)
              : _buildTaskList(context, ref, state),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteNames.createTask),
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
            Icons.task_alt,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withAlpha(50),
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first task to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(
    BuildContext context,
    WidgetRef ref,
    TaskState state,
  ) {
    final tasks = state.filteredTasks;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return _TaskCard(
          task: task,
          onComplete: () {
            ref.read(taskProvider.notifier).completeTask(task.id);
          },
          onTap: () => context.push('/tasks/${task.id}'),
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Tasks'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Status'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: ref.read(taskProvider).filterStatus == null,
                  onSelected: (_) {
                    ref.read(taskProvider.notifier).clearFilters();
                    Navigator.pop(context);
                  },
                ),
                ...TaskStatus.values.map((status) {
                  return FilterChip(
                    label: Text(status.label),
                    selected: ref.read(taskProvider).filterStatus == status.name,
                    onSelected: (_) {
                      ref.read(taskProvider.notifier).setFilter(
                        status: status.name,
                      );
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Priority'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ...TaskPriority.values.map((priority) {
                  return FilterChip(
                    label: Text(priority.label),
                    selected: ref.read(taskProvider).filterPriority == priority.name,
                    onSelected: (_) {
                      ref.read(taskProvider.notifier).setFilter(
                        priority: priority.name,
                      );
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(taskProvider.notifier).clearFilters();
              Navigator.pop(context);
            },
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onComplete;
  final VoidCallback onTap;

  const _TaskCard({
    required this.task,
    required this.onComplete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Checkbox(
                value: task.status == TaskStatus.completed,
                onChanged: (_) => onComplete(),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.status == TaskStatus.completed
                            ? TextDecoration.lineThrough
                            : null,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (task.deadline != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Due: ${task.deadline.toString().split(' ')[0]}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: task.isOverdue
                              ? Theme.of(context).colorScheme.error
                              : null,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              _buildPriorityBadge(context, task.priority),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(BuildContext context, TaskPriority priority) {
    Color color;
    switch (priority) {
      case TaskPriority.urgent:
        color = Theme.of(context).colorScheme.error;
        break;
      case TaskPriority.high:
        color = Colors.orange;
        break;
      case TaskPriority.medium:
        color = Colors.blue;
        break;
      case TaskPriority.low:
        color = Colors.green;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        priority.label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
