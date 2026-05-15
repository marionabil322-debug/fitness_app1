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
  ];

  static const List<Exercise> exercises = [
    Exercise(
      name: 'Barbell Squat',
      muscle: 'Legs • Glutes',
      sets: '4 sets × 10 reps',
      duration: '45 min',
      difficulty: 'Hard',
      description:
          'A compound lower-body movement targeting quads, hamstrings, and glutes.',
      icon: Icons.fitness_center,
      color: AppColors.primary,
      calories: 320,
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
  ];

  static const List<double> weekActivity = [45, 30, 60, 0, 50, 75, 40];
  static const List<String> weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  static String userName = 'Alex Johnson';
  static String userAge = '28';
  static String userHeight = '178';
  static String userWeight = '76.5';
  static String userGender = 'Male';
}
