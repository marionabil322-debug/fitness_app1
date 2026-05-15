import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/exercise_list_screen.dart';
import 'screens/active_workout_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/profile_Screen.dart';
import 'screens/workout_history_screen.dart';

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {                       
    return MaterialApp(
      title: 'FitPulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(), //
        '/exercises': (_) => const ExerciseListScreen(), //
        '/active-workout': (_) => const ActiveWorkoutScreen(), //
        '/statistics': (_) => const StatisticsScreen(), //
        '/profile': (_) => const ProfileScreen(), //
        '/history': (_) => const WorkoutHistoryScreen(), //
      },
    );
  }
}
