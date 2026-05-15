import 'package:fitness_app1/core/theme/app_colors.dart';
import 'package:fitness_app1/core/widgets/app_botton.dart';
import 'package:flutter/material.dart';
import '../data/app_data.dart';

class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ex =
        ModalRoute.of(context)?.settings.arguments as Exercise? ??
        AppData.exercises.first;

    return Scaffold(
      appBar: AppBar(title: Text(ex.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video placeholder
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: ex.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ex.color.withOpacity(0.3)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(ex.icon, color: ex.color, size: 52),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: ex.color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Demo Video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Stats chips
            Row(
              children: [
                _Chip(
                  label: ex.duration,
                  icon: Icons.timer_outlined,
                  color: AppColors.green,
                ),
                const SizedBox(width: 8),
                _Chip(
                  label: ex.difficulty,
                  icon: Icons.fitness_center,
                  color: ex.color,
                ),
                const SizedBox(width: 8),
                _Chip(
                  label: '${ex.calories} kcal',
                  icon: Icons.local_fire_department,
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Muscle
            const Text(
              'Muscle Group',
              style: TextStyle(color: AppColors.textSub, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              ex.muscle,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 16),

            // Sets
            const Text(
              'Sets & Reps',
              style: TextStyle(color: AppColors.textSub, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              ex.sets,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            const Text(
              'About',
              style: TextStyle(color: AppColors.textSub, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              ex.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 28),

            AppButton(
              label: 'Add to Workout',
              icon: Icons.add,
              onPressed: () => Navigator.pushNamed(context, '/active-workout'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _Chip({required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
