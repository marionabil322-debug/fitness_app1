import 'package:fitness_app1/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../core/widgets/item_tile.dart';
import '../data/app_data.dart';

class ExerciseListScreen extends StatefulWidget {
  final dynamic category;

  const ExerciseListScreen({super.key, this.category});

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  String _search = '';
  @override
  Widget build(BuildContext context) {
    final cat = ModalRoute.of(context)?.settings.arguments as Category?;
    final list = AppData.exercises
        .where((e) => e.name.toLowerCase().contains(_search.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(cat?.name ?? 'Exercises')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              decoration: const InputDecoration(
                hintText: 'Search exercises...',
                prefixIcon:
                    Icon(Icons.search, color: AppColors.textSub, size: 20),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: list.length,
              itemBuilder: (_, i) => ItemTile(
                title: list[i].name,
                subtitle: '${list[i].muscle}  •  ${list[i].sets}',
                icon: list[i].icon,
                color: list[i].color,
                trailing: '${list[i].calories} kcal',
                onTap: () => Navigator.pushNamed(context, '/exercise-detail',
                    arguments: list[i]),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/active-workout'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
        label: const Text('Start',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
