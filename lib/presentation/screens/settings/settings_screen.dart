import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../bloc/settings/settings_bloc.dart';
import 'privacy_policy_screen.dart';

/// Settings screen — reads/dispatches to the *root-level* [SettingsBloc]
/// (provided once in main.dart) since theme mode drives the whole app,
/// not just this screen.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const _SectionTitle('Appearance'),
              Row(
                children: [
                  Expanded(
                    child: _ModeButton(
                      label: 'Light Mode',
                      icon: Icons.wb_sunny_outlined,
                      selected: state.themeMode == ThemeMode.light,
                      onTap: () => context
                          .read<SettingsBloc>()
                          .add(const ThemeModeToggled(ThemeMode.light)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ModeButton(
                      label: 'Dark Mode',
                      icon: Icons.nightlight_outlined,
                      selected: state.themeMode == ThemeMode.dark,
                      onTap: () => context
                          .read<SettingsBloc>()
                          .add(const ThemeModeToggled(ThemeMode.dark)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const _SectionTitle('Preferences'),
              _SwitchTile(
                icon: Icons.notifications_none,
                title: 'Quote Notifications',
                subtitle: 'Daily inspiration',
                value: state.notificationsEnabled,
                onChanged: (_) =>
                    context.read<SettingsBloc>().add(const NotificationsToggled()),
              ),
              _SwitchTile(
                icon: Icons.copy_outlined,
                title: 'Auto Copy Quote',
                subtitle: 'Copy to clipboard',
                value: state.autoCopyEnabled,
                onChanged: (_) =>
                    context.read<SettingsBloc>().add(const AutoCopyToggled()),
              ),
              _NavTile(
                icon: Icons.format_size,
                title: 'Font Size',
                value: _fontSizeLabel(state.fontSize),
                onTap: () => _showFontSizeSheet(context),
              ),
              const SizedBox(height: 24),
              const _SectionTitle('More'),
              _NavTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen(),
                      ),
                    );
                  }),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('App Version', style: TextStyle(color: Colors.grey.shade500)),
                  Text('1.0.0', style: TextStyle(color: Colors.grey.shade500)),
                ],
              ),
              const SizedBox(height: 12),
            ],
          );
        },
      ),
    );
  }

  String _fontSizeLabel(AppFontSize size) {
    switch (size) {
      case AppFontSize.small:
        return 'Small';
      case AppFontSize.medium:
        return 'Medium';
      case AppFontSize.large:
        return 'Large';
    }
  }

  void _showFontSizeSheet(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: AppFontSize.values.map((size) {
              return ListTile(
                title: Text(_fontSizeLabel(size)),
                onTap: () {
                  bloc.add(FontSizeChanged(size));
                  Navigator.pop(sheetContext);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _ModeButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(0.08)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: selected ? AppColors.primary : Colors.grey),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: selected ? AppColors.primary : Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        secondary: Icon(icon, color: Colors.grey.shade600),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
        ),
        value: value,
        activeColor: AppColors.primary,
        onChanged: onChanged,
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  final VoidCallback onTap;

  const _NavTile({
    required this.icon,
    required this.title,
    this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey.shade600),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (value != null)
              Text(value!, style: TextStyle(color: Colors.grey.shade500)),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
