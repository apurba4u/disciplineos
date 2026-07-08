import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/voice_provider.dart';

class VoiceButton extends ConsumerWidget {
  final VoidCallback? onPressed;

  const VoiceButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(voiceProvider);

    return FloatingActionButton(
      onPressed: state.isListening
          ? () => ref.read(voiceProvider.notifier).stopListening()
          : () {
              ref.read(voiceProvider.notifier).startListening();
              onPressed?.call();
            },
      backgroundColor: state.isListening
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.primary,
      child: Icon(
        state.isListening ? Icons.mic : Icons.mic_none,
        color: Colors.white,
      ),
    );
  }
}
