import 'package:fitness_app1/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/widgets/item_tile.dart';
import '../data/app_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final _nameCtrl = TextEditingController(text: AppData.userName);
  late final _ageCtrl = TextEditingController(text: AppData.userAge);
  late final _heightCtrl = TextEditingController(text: AppData.userHeight);
  late final _weightCtrl = TextEditingController(text: AppData.userWeight);

  late String _gender = AppData.userGender;

  String gender = 'Male';
  bool _isEditing = false;

  double get _height => double.tryParse(_heightCtrl.text) ?? 0;
  double get _weight => double.tryParse(_weightCtrl.text) ?? 0;

  double get _bmi {
    if (_height <= 0 || _weight <= 0) return 0;
    return _weight / ((_height / 100) * (_height / 100));
  }

  String get _bmiFormatted => _bmi > 0 ? _bmi.toStringAsFixed(1) : '--';

  String get _bmiCategory {
    if (_bmi <= 0) return '';
    if (_bmi < 18.5) return 'Underweight';
    if (_bmi < 25.0) return 'Normal';
    if (_bmi < 30.0) return 'Overweight';
    return 'Obese';
  }

  Color get _bmiColor {
    if (_bmi < 18.5) return const Color(0xFF2196F3);
    if (_bmi < 25.0) return AppColors.green;
    if (_bmi < 30.0) return const Color(0xFFFFC107);
    return const Color(0xFFF44336);
  }

  int get _totalCalories => AppData.history.fold(0, (s, h) => s + h.calories);
  int get _totalSessions => AppData.history.length;
  String get _totalCaloriesFormatted => _totalCalories >= 1000
      ? '${(_totalCalories / 1000).toStringAsFixed(1)}k'
      : '$_totalCalories';
  String get _totalTimeFormatted {
    final mins = AppData.history.fold(0, (s, h) => s + h.minutes);
    return '${mins ~/ 60}h';
  }

  String get _initials {
    final parts = _nameCtrl.text.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    if (parts[0].isNotEmpty) return parts[0][0].toUpperCase();
    return '?';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          TextButton(
            onPressed: () => setState(() {
              if (_isEditing) {
                AppData.userName = _nameCtrl.text;
                AppData.userAge = _ageCtrl.text;
                AppData.userHeight = _heightCtrl.text;
                AppData.userWeight = _weightCtrl.text;
                AppData.userGender = _gender;
              }
              _isEditing = !_isEditing;
            }),
            child: Text(
              _isEditing ? 'Done' : 'Edit',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  _initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _isEditing
                ? _InputField(
                    controller: _nameCtrl,
                    label: 'Full Name',
                    icon: Icons.person_outline,
                    onChanged: (_) => setState(() {}),
                  )
                : Text(
                    _nameCtrl.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
            const SizedBox(height: 4),

            _isEditing
                ? _GenderToggle(
                    selected: _gender,
                    onChanged: (v) => setState(() => _gender = v),
                  )
                : Text(
                    '$_gender  •  ${_ageCtrl.text} yrs',
                    style: const TextStyle(
                      color: AppColors.textSub,
                      fontSize: 13,
                    ),
                  ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _Stat('$_totalSessions', 'Workouts'),
                  const _Vline(),
                  _Stat(_totalTimeFormatted, 'Active'),
                  const _Vline(),
                  _Stat(_totalCaloriesFormatted, 'Calories'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Body Info',
                style: TextStyle(color: AppColors.textSub, fontSize: 12),
              ),
            ),
            const SizedBox(height: 8),

            _isEditing
                ? Container(
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _InputField(
                          controller: _ageCtrl,
                          label: 'Age (yrs)',
                          icon: Icons.cake_outlined,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 10),
                        _InputField(
                          controller: _heightCtrl,
                          label: 'Height (cm)',
                          icon: Icons.height,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'),
                            ),
                          ],
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 10),
                        _InputField(
                          controller: _weightCtrl,
                          label: 'Weight (kg)',
                          icon: Icons.monitor_weight_outlined,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'),
                            ),
                          ],
                          onChanged: (_) => setState(() {}),
                        ),
                      ],
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        _InfoRow(
                          icon: Icons.wc,
                          label: 'Gender',
                          value: _gender,
                        ),
                        _divider(),
                        _InfoRow(
                          icon: Icons.cake_outlined,
                          label: 'Age',
                          value: '${_ageCtrl.text} yrs',
                        ),
                        _divider(),
                        _InfoRow(
                          icon: Icons.height,
                          label: 'Height',
                          value: '${_heightCtrl.text} cm',
                        ),
                        _divider(),
                        _InfoRow(
                          icon: Icons.monitor_weight_outlined,
                          label: 'Weight',
                          value: '${_weightCtrl.text} kg',
                        ),
                        _divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 13,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.analytics_outlined,
                                color: AppColors.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 14),
                              const Expanded(
                                child: Text(
                                  'BMI',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _bmiColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '$_bmiFormatted · $_bmiCategory',
                                  style: TextStyle(
                                    color: _bmiColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 20),

            // ── Menu ──────────────────────────────────────────────────────────
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Settings',
                style: TextStyle(color: AppColors.textSub, fontSize: 12),
              ),
            ),
            const SizedBox(height: 8),
            ItemTile(
              title: 'My Goals',
              subtitle: '3 active goals',
              icon: Icons.flag_outlined,
              color: AppColors.primary,
              onTap: () => Navigator.pushNamed(context, '/goals'),
            ),
            ItemTile(
              title: 'Workout History',
              subtitle: '$_totalSessions sessions',
              icon: Icons.history_outlined,
              color: AppColors.green,
              onTap: () => Navigator.pushNamed(context, '/history'),
            ),
            ItemTile(
              title: 'Settings',
              subtitle: 'Notifications & more',
              icon: Icons.settings_outlined,
              color: AppColors.textSub,
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNav(index: 3),
    );
  }

  static Widget _divider() =>
      const Divider(height: 1, indent: 54, color: AppColors.surface);
}

class _GenderToggle extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;
  const _GenderToggle({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ['Male', 'Female'].map((g) {
        final isSelected = selected == g;
        return GestureDetector(
          onTap: () => onChanged(g),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.surface,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  g == 'Male' ? Icons.male : Icons.female,
                  color: isSelected ? Colors.white : AppColors.textSub,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  g,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textSub,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textSub, fontSize: 13),
        prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  const _Stat(this.value, this.label);
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      Text(
        label,
        style: const TextStyle(color: AppColors.textSub, fontSize: 11),
      ),
    ],
  );
}

class _Vline extends StatelessWidget {
  const _Vline();
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 32, color: AppColors.surface);
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: AppColors.textSub, fontSize: 13),
          ),
        ],
      ),
    );
  }
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
