import 'package:fitness_app1/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  final Color color;
  final int count;
  const Category(this.name, this.icon, this.color, this.count);
}

class Exercise {
  final String name;
  final String muscle;
  final String sets;
  final String duration;
  final String difficulty;
  final String description;
  final IconData icon;
  final Color color;
  final int calories;
  const Exercise({
    required this.name,
    required this.muscle,
    required this.sets,
    required this.duration,
    required this.difficulty,
    required this.description,
    required this.icon,
    required this.color,
    required this.calories,
  });
}

class HistoryItem {
  final String name;
  final String category;
  final DateTime date;
  final int minutes;
  final int calories;
  const HistoryItem(
    this.name,
    this.category,
    this.date,
    this.minutes,
    this.calories,
  );
}

class AppData {
  static const List<Category> categories = [
    Category('Strength', Icons.fitness_center, AppColors.primary, 24),
    Category('Cardio', Icons.directions_run, AppColors.green, 18),
    Category('HIIT', Icons.bolt, Color(0xFFFFC107), 12),
    Category('Yoga', Icons.self_improvement, Color(0xFF9C27B0), 15),
    Category('Flexibility', Icons.accessibility_new, Color(0xFF2196F3), 10),
    Category('Sports', Icons.sports_soccer, Color(0xFF4CAF50), 8),
  ];

  static const List<Exercise> exercises = [
    Exercise(
      name: 'Barbell Squat',
      muscle: 'Legs • Glutes',
      sets: '4 sets × 10 reps',
      duration: '45 min',
      difficulty: 'Hard',
      description:
          'A compound lower-body movement targeting quads, hamstrings, and glutes. One of the best exercises for building lower-body strength and size.',
      icon: Icons.fitness_center,
      color: AppColors.primary,
      calories: 320,
    ),
    Exercise(
      name: 'Bench Press',
      muscle: 'Chest • Triceps',
      sets: '4 sets × 8 reps',
      duration: '40 min',
      difficulty: 'Medium',
      description:
          'Classic upper-body push exercise targeting chest, shoulders, and triceps. A staple for building pressing strength.',
      icon: Icons.sports_gymnastics,
      color: AppColors.primary,
      calories: 280,
    ),
    Exercise(
      name: 'Treadmill Run',
      muscle: 'Full Body',
      sets: '1 session',
      duration: '30 min',
      difficulty: 'Easy',
      description:
          'Steady-state cardio that improves cardiovascular health, burns calories, and builds aerobic endurance.',
      icon: Icons.directions_run,
      color: AppColors.green,
      calories: 350,
    ),
    Exercise(
      name: 'Burpees',
      muscle: 'Full Body',
      sets: '5 rounds × 10',
      duration: '25 min',
      difficulty: 'Hard',
      description:
          'High-intensity full-body movement combining squat, push-up, and jump. Great for conditioning and calorie burn.',
      icon: Icons.bolt,
      color: Color(0xFFFFC107),
      calories: 400,
    ),
    Exercise(
      name: 'Deadlift',
      muscle: 'Back • Hamstrings',
      sets: '3 sets × 6 reps',
      duration: '35 min',
      difficulty: 'Hard',
      description:
          'Fundamental compound pull targeting the entire posterior chain. One of the best exercises for overall strength.',
      icon: Icons.fitness_center,
      color: AppColors.primary,
      calories: 360,
    ),
    Exercise(
      name: 'Warrior Pose',
      muscle: 'Hips • Core',
      sets: '3 × 60 sec hold',
      duration: '20 min',
      difficulty: 'Easy',
      description:
          'Foundational yoga pose that builds lower-body stability, opens the hips, and improves balance.',
      icon: Icons.self_improvement,
      color: Color(0xFF9C27B0),
      calories: 90,
    ),
  ];

  static final List<HistoryItem> history = [
    HistoryItem(
      'Full Body Strength',
      'Strength',
      DateTime.now().subtract(const Duration(days: 1)),
      55,
      420,
    ),
    HistoryItem(
      'Morning Cardio',
      'Cardio',
      DateTime.now().subtract(const Duration(days: 2)),
      35,
      310,
    ),
    HistoryItem(
      'HIIT Circuit',
      'HIIT',
      DateTime.now().subtract(const Duration(days: 4)),
      28,
      380,
    ),
    HistoryItem(
      'Upper Body Push',
      'Strength',
      DateTime.now().subtract(const Duration(days: 5)),
      48,
      350,
    ),
    HistoryItem(
      'Yoga Flow',
      'Yoga',
      DateTime.now().subtract(const Duration(days: 7)),
      40,
      180,
    ),
    HistoryItem(
      'Leg Day',
      'Strength',
      DateTime.now().subtract(const Duration(days: 9)),
      62,
      490,
    ),
  ];

  static const List<double> weekActivity = [45, 30, 60, 0, 50, 75, 40];
  static const List<String> weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
}
