import 'package:flutter/material.dart' hide LocalKey;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:e_commerce_app/app/routing/routes.dart';
import 'package:e_commerce_app/core/constant/local_key.dart';
import 'package:e_commerce_app/core/local_storage/base_local_storage.dart';
import 'package:e_commerce_app/injection_container.dart';
import 'package:e_commerce_app/presentaion/cubit/app_theme_cubit.dart';
import 'package:e_commerce_app/presentaion/cubit/app_theme_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 202, 234),
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          final isDark = state.isDark;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SwitchListTile(
                    title: const Text(
                      "Dark Mode",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    secondary: Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      color: isDark ? Colors.orangeAccent : Colors.amber,
                    ),
                    value: isDark,
                    onChanged: (_) {
                      context.read<AppThemeCubit>().toggleTheme();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.delete),
                    label: const Text(
                      'Delete Local Data',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      final localStorage = getIt<BaseLocalStorage>();
                      await localStorage.setBool(LocalKey.isOpen, false);
                      await localStorage.setBool(LocalKey.isDark, false);
                      if (context.mounted) {
                        context.read<AppThemeCubit>().resetTheme();
                        context.goNamed(Routes.onboardingPage);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}