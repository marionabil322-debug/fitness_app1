import 'package:fitness_app1/core/theme/app_colors.dart';
import 'package:fitness_app1/core/widgets/app_botton.dart';
import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../utils/helpers.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalCal = AppData.history.fold(0, (s, h) => s + h.calories);
    final totalMin = AppData.history.fold(0, (s, h) => s + h.minutes);

    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: Column(
        children: [
          // Summary
          Container(
            margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _SumItem('${AppData.history.length}', 'Sessions'),
                Container(width: 1, height: 30, color: Colors.white30),
                _SumItem(Helpers.formatDuration(totalMin), 'Total Time'),
                Container(width: 1, height: 30, color: Colors.white30),
                _SumItem('$totalCal kcal', 'Burned'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: AppData.history.length,
              itemBuilder: (_, i) {
                final h = AppData.history[i];
                return GestureDetector(
                  onTap: () => _showDetail(context, h),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              Helpers.emoji(h.category),
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    h.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    Helpers.formatDate(h.date),
                                    style: const TextStyle(
                                      color: AppColors.textSub,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              color: AppColors.textSub,
                              size: 16,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _Mini(
                                Icons.timer_outlined,
                                Helpers.formatDuration(h.minutes),
                                AppColors.green,
                              ),
                              _Mini(
                                Icons.local_fire_department,
                                '${h.calories} kcal',
                                Colors.orange,
                              ),
                              _Mini(
                                Icons.label_outline,
                                h.category,
                                AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/categories'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Log Workout',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: const _BottomNav(index: 2),
    );
  }

  void _showDetail(BuildContext context, HistoryItem h) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${Helpers.emoji(h.category)} ${h.name}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              Helpers.formatDate(h.date),
              style: const TextStyle(color: AppColors.textSub),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _DetailItem(
                  Icons.timer_outlined,
                  Helpers.formatDuration(h.minutes),
                  'Duration',
                  AppColors.green,
                ),
                _DetailItem(
                  Icons.local_fire_department,
                  '${h.calories}',
                  'Calories',
                  Colors.orange,
                ),
                _DetailItem(
                  Icons.label_outline,
                  h.category,
                  'Type',
                  AppColors.primary,
                ),
              ],
            ),
            const SizedBox(height: 20),
            AppButton(
              label: 'Repeat Workout',
              icon: Icons.replay,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/active-workout');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SumItem extends StatelessWidget {
  final String v, l;
  const _SumItem(this.v, this.l);
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        v,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
      Text(l, style: const TextStyle(color: Colors.white70, fontSize: 11)),
    ],
  );
}

class _Mini extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _Mini(this.icon, this.label, this.color);
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: color, size: 13),
      const SizedBox(width: 4),
      Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String value, label;
  final Color color;
  const _DetailItem(this.icon, this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Icon(icon, color: color, size: 24),
      const SizedBox(height: 4),
      Text(
        value,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
      Text(
        label,
        style: const TextStyle(color: AppColors.textSub, fontSize: 11),
      ),
    ],
  );
}

class _BottomNav extends StatelessWidget {
  final int index;
  const _BottomNav({required this.index});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      backgroundColor: AppColors.card,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSub,
      type: BottomNavigationBarType.fixed,
      onTap: (i) {
        const routes = ['/', '/statistics', '/history', '/profile'];
        if (i != index) Navigator.pushReplacementNamed(context, routes[i]);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          activeIcon: Icon(Icons.bar_chart),
          label: 'Stats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_outlined),
          activeIcon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
