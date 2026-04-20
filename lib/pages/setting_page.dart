import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../View/ledgerPage/ledger_page_bloc.dart';
import '../View/settingPage/setting_page_bloc.dart';
import '../data/repositories/auth_repository.dart';
import 'login_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingPageBloc(authRepository: AuthRepository()),
      child: BlocListener<SettingPageBloc, SettingPageState>(
        listener: (context, state) {
          if (state is SettingLogoutSuccess) {
            // 3. Navigate to Login Page and destroy all previous routes
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false,
            );
          } else if (state is SettingLogoutFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("try again")),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0XFF0a1625),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: BlocBuilder<SettingPageBloc, SettingPageState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      context.read<SettingPageBloc>().add(LogoutRequested());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A222D),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                          color: Color(0xFFF25454),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
