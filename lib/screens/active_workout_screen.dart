import 'dart:async';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/widgets/app_botton.dart';
import 'package:flutter/material.dart';
import '../core/widgets/item_tile.dart';
import '../data/app_data.dart';
import '../utils/helpers.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  Timer? _timer;
  int _seconds = 0;
  bool _running = false;
  int _exIndex = 0;
  int _set = 1;

  final _exercises = AppData.exercises.take(4).toList();

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggle() {
    if (_running) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => _seconds++);
      });
    }
    setState(() => _running = !_running);
  }

  void _next() {
    final maxSets =
        int.tryParse(_exercises[_exIndex].sets.split(' ').first) ?? 3;
    if (_set < maxSets) {
      setState(() => _set++);
    } else if (_exIndex < _exercises.length - 1) {
      setState(() {
        _exIndex++;
        _set = 1;
      });
    } else {
      _timer?.cancel();
      _showDone();
    }
  }

  void _showDone() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text(
          '🏆 Workout Done!',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Time: ${Helpers.formatTimer(_seconds)}\nExercises: ${_exercises.length}',
          style: const TextStyle(color: AppColors.textSub),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ex = _exercises[_exIndex];
    final maxSets = int.tryParse(ex.sets.split(' ').first) ?? 3;
    final progress =
        (_exIndex * maxSets + _set) / (_exercises.length * maxSets);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Workout'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                Helpers.formatTimer(_seconds),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.surface,
                color: AppColors.primary,
                minHeight: 6,
              ),
            ),
            Text(
              'Exercise ${_exIndex + 1} of ${_exercises.length}',
              style: const TextStyle(color: AppColors.textSub, fontSize: 12),
            ),
            const SizedBox(height: 20),

            // Current exercise card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: ex.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: ex.color.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Icon(ex.icon, color: ex.color, size: 52),
                  const SizedBox(height: 12),
                  Text(
                    ex.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Set $_set of $maxSets  •  ${ex.sets.split('×').last.trim()}',
                    style: const TextStyle(
                      color: AppColors.textSub,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Big timer
            Text(
              Helpers.formatTimer(_seconds),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 64,
                fontWeight: FontWeight.w800,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: 28),

            // Controls
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: _running ? 'Pause' : 'Start',
                    icon: _running
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    outlined: true,
                    onPressed: _toggle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    label: _set < maxSets ? 'Next Set' : 'Next Exercise',
                    icon: Icons.check_rounded,
                    onPressed: _running ? _next : null,
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Up next
            if (_exIndex < _exercises.length - 1) ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Up next',
                  style: TextStyle(color: AppColors.textSub, fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
              ItemTile(
                title: _exercises[_exIndex + 1].name,
                subtitle: _exercises[_exIndex + 1].sets,
                icon: _exercises[_exIndex + 1].icon,
                color: _exercises[_exIndex + 1].color,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
