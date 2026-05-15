// app.dart
import 'package:fitness_app1/core/theme/theme_provider.dart';
import 'package:fitness_app1/screens/active_workout_screen.dart';
import 'package:fitness_app1/screens/exercise_detail_screen.dart';
import 'package:fitness_app1/screens/exercise_list_screen.dart';
import 'package:fitness_app1/screens/goal_setting.dart';
import 'package:fitness_app1/screens/home_screen.dart';
import 'package:fitness_app1/screens/profile_screen.dart';
import 'package:fitness_app1/screens/settings_screen.dart';
import 'package:fitness_app1/screens/statistics_screen.dart';
import 'package:fitness_app1/screens/workout_categories_screen.dart';
import 'package:fitness_app1/screens/workout_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ استدعاء الـ provider هنا
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'FitPulse',
      debugShowCheckedModeBanner: false,

      // ✅ ربط الـ themeMode بالنسخة النشطة من الـ Provider
      themeMode: themeProvider.themeMode,

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/categories': (_) => const WorkoutCategoriesScreen(),
        '/exercises': (_) => const ExerciseListScreen(),
        '/exercise-detail': (_) => const ExerciseDetailScreen(),
        '/active-workout': (_) => const ActiveWorkoutScreen(),
        '/statistics': (_) => const StatisticsScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/goals': (_) => const GoalSettingScreen(),
        '/history': (_) => const WorkoutHistoryScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
    );
  }
}
