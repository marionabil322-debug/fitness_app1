import 'package:fitness_app1/core/theme/app_colors.dart';
import 'package:fitness_app1/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _workoutReminders = true;
  bool _goalAlerts = true;
  bool _weeklyReport = true;
  bool _darkMode = true;
  bool _sound = true;
  bool _haptic = true;
  bool _metric = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),
          _Label('PREFERENCES'),
          const SizedBox(height: 8),
          _Card(
            children: [
              _Switch(
                icon: Icons.dark_mode_outlined,
                iconColor: const Color(0xFF9C27B0),
                label: 'Dark Mode',
                value:
                    Provider.of<ThemeProvider>(context).themeMode ==
                    ThemeMode.dark,
                onChanged: (v) {
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).toggleTheme(v);
                },
              ),

              _div(),
              _Switch(
                icon: Icons.straighten_outlined,
                iconColor: AppColors.primary,
                label: 'Metric Units (kg, cm)',
                value: _metric,
                onChanged: (v) => setState(() => _metric = v),
              ),
              _div(),
              _Switch(
                icon: Icons.volume_up_outlined,
                iconColor: Colors.orange,
                label: 'Sound Effects',
                value: _sound,
                onChanged: (v) => setState(() => _sound = v),
              ),
              _div(),
              _Switch(
                icon: Icons.vibration_outlined,
                iconColor: Colors.teal,
                label: 'Haptic Feedback',
                value: _haptic,
                onChanged: (v) => setState(() => _haptic = v),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Account
          _Label('ACCOUNT'),
          const SizedBox(height: 8),
          _Card(
            children: [
              _Nav(
                icon: Icons.person_outline,
                iconColor: AppColors.green,
                label: 'Edit Profile',
                onTap: () => Navigator.pushNamed(context, '/profile'),
              ),
              _div(),
              _Nav(
                icon: Icons.flag_outlined,
                iconColor: AppColors.primary,
                label: 'Set Goals',
                onTap: () => Navigator.pushNamed(context, '/goals'),
              ),
              _div(),
              _Nav(
                icon: Icons.lock_outline,
                iconColor: AppColors.textSub,
                label: 'Change Password',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Support
          _Label('SUPPORT'),
          const SizedBox(height: 8),
          _Card(
            children: [
              _Nav(
                icon: Icons.help_outline,
                iconColor: AppColors.green,
                label: 'Help Center',
                onTap: () {},
              ),
              _div(),
              _Nav(
                icon: Icons.star_outline,
                iconColor: Colors.amber,
                label: 'Rate the App',
                onTap: () {},
              ),
              _div(),
              _Nav(
                icon: Icons.privacy_tip_outlined,
                iconColor: AppColors.textSub,
                label: 'Privacy Policy',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Danger
          _Card(
            children: [
              _Nav(
                icon: Icons.logout,
                iconColor: Colors.red,
                label: 'Log Out',
                textColor: Colors.red,
                onTap: () => _confirm(
                  context,
                  'Log out?',
                  'You will be signed out.',
                  () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'FitPulse v1.0.0',
              style: TextStyle(color: AppColors.textSub, fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _confirm(
    BuildContext context,
    String title,
    String msg,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        content: Text(msg, style: const TextStyle(color: AppColors.textSub)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text('Confirm', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  static Widget _div() =>
      const Divider(height: 1, indent: 54, color: AppColors.surface);
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      color: AppColors.textSub,
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.1,
    ),
  );
}

class _Card extends StatelessWidget {
  final List<Widget> children;
  const _Card({required this.children});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(children: children),
  );
}

class _Switch extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _Switch({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: iconColor, size: 20),
    title: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 14),
    ),
    trailing: Switch(value: value, onChanged: onChanged),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    visualDensity: VisualDensity.compact,
  );
}

class _Nav extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback? onTap;
  final Color? textColor;
  const _Nav({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: iconColor, size: 20),
    title: Text(
      label,
      style: TextStyle(color: textColor ?? Colors.white, fontSize: 14),
    ),
    trailing: const Icon(
      Icons.chevron_right,
      color: AppColors.textSub,
      size: 16,
    ),
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    visualDensity: VisualDensity.compact,
  );
}
