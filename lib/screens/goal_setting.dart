import 'package:fitness_app1/core/theme/app_colors.dart';
import 'package:fitness_app1/core/widgets/app_botton.dart';
import 'package:flutter/material.dart';

class GoalSettingScreen extends StatefulWidget {
  const GoalSettingScreen({super.key});

  @override
  State<GoalSettingScreen> createState() => _GoalSettingScreenState();
}

class _GoalSettingScreenState extends State<GoalSettingScreen> {
  double _steps = 10000;
  double _workouts = 5;
  double _weight = 72;
  double _water = 8;
  String _goal = 'Build Muscle';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Goals')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today's progress
            const Text(
              'Today',
              style: TextStyle(color: AppColors.textSub, fontSize: 12),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _ProgressCard(
                    '👟',
                    'Steps',
                    7432,
                    _steps.toInt(),
                    AppColors.green,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ProgressCard(
                    '💧',
                    'Water',
                    5,
                    _water.toInt(),
                    AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Sliders
            const Text(
              'Set Targets',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),

            _SliderCard(
              icon: Icons.directions_walk,
              label: 'Daily Steps',
              value: _steps,
              min: 2000,
              max: 20000,
              display: '${(_steps / 1000).toStringAsFixed(1)}k',
              color: AppColors.green,
              onChanged: (v) => setState(() => _steps = v),
            ),
            const SizedBox(height: 10),
            _SliderCard(
              icon: Icons.fitness_center,
              label: 'Weekly Workouts',
              value: _workouts,
              min: 1,
              max: 7,
              display: '${_workouts.toInt()} days',
              color: AppColors.primary,
              onChanged: (v) => setState(() => _workouts = v),
            ),
            const SizedBox(height: 10),
            _SliderCard(
              icon: Icons.monitor_weight_outlined,
              label: 'Weight Goal',
              value: _weight,
              min: 40,
              max: 150,
              display: '${_weight.toInt()} kg',
              color: Colors.orange,
              onChanged: (v) => setState(() => _weight = v),
            ),
            const SizedBox(height: 10),
            _SliderCard(
              icon: Icons.water_drop_outlined,
              label: 'Daily Water',
              value: _water,
              min: 2,
              max: 16,
              display: '${_water.toInt()} glasses',
              color: const Color(0xFF2196F3),
              onChanged: (v) => setState(() => _water = v),
            ),
            const SizedBox(height: 20),

            // Goal type
            const Text(
              'Primary Goal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ...[
              'Build Muscle',
              'Lose Weight',
              'Stay Healthy',
              'Improve Endurance',
            ].map(
              (g) => GestureDetector(
                onTap: () => setState(() => _goal = g),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _goal == g
                        ? AppColors.primary.withOpacity(0.12)
                        : AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _goal == g
                          ? AppColors.primary
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(_goalEmoji(g), style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 12),
                      Text(
                        g,
                        style: TextStyle(
                          color: _goal == g ? AppColors.primary : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      if (_goal == g)
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppButton(
              label: 'Save Goals',
              icon: Icons.check_rounded,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Goals saved! 🎯'),
                    backgroundColor: AppColors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _goalEmoji(String g) {
    switch (g) {
      case 'Build Muscle':
        return '💪';
      case 'Lose Weight':
        return '🏃';
      case 'Stay Healthy':
        return '🧘';
      default:
        return '⚡';
    }
  }
}

class _ProgressCard extends StatelessWidget {
  final String emoji;
  final String label;
  final int current;
  final int goal;
  final Color color;
  const _ProgressCard(
    this.emoji,
    this.label,
    this.current,
    this.goal,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    final p = (current / goal).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 6),
          Text(
            '$current / $goal',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: AppColors.textSub, fontSize: 11),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: p,
              backgroundColor: AppColors.surface,
              color: color,
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final double value;
  final double min, max;
  final String display;
  final Color color;
  final ValueChanged<double> onChanged;
  const _SliderCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.display,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  display,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color,
              thumbColor: color,
              inactiveTrackColor: AppColors.surface,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
