import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/View/signup/signup_bloc.dart';
import 'package:income_and_expense_tracker/data/repositories/auth_repository.dart';
import 'package:income_and_expense_tracker/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'create_acc_page.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final _emailController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => SignupBloc(authRepository: AuthRepository()),
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/icon/back_icon.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Create Account',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter your email to get started',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 25),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    ' Email Address',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'name@example.com',
                      hintStyle: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  BlocConsumer<SignupBloc, SignupState>(
                    listener: (context, state) {
                      if (state is SignupNavigateToOtpActionState) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CreateAccPage(),
                          ),
                        );
                      }

                      if (state is SignupEmailSentSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Check your email for the verification link!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }

                      if (state is SignupError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errorMessage),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return InkWell(
                        onTap: state is SignupLoading
                            ? null
                            : () async {
                          final email = _emailController.text.trim();

                          if (email.isNotEmpty && email.contains('@')) {
                            final prefs =
                            await SharedPreferences.getInstance();
                            await prefs.setString('user_email', email);

                            if (!context.mounted) return;

                            // context
                            //     .read<SignupBloc>()
                            //     .add(EmailSubmitted(email));
                            // ------------------------------------


                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CreateAccPage(),
                              ),
                            );
                            // -----------------------------

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Please enter a valid email address")),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: state is SignupLoading
                                ? Colors.blue.withOpacity(0.7)
                                : Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (state is SignupLoading)
                                const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              else
                                const Text(
                                  'Continue',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 240),
                  const Center(
                    child: Text(
                      'Or Sign Up With',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icon/google_icon.png',
                              width: 25,
                              height: 25,
                            ),
                            Text(
                              ' Google',
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icon/apple_icon.png',
                              width: 25,
                              height: 25,
                            ),
                            Text(
                              ' Apple',
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 17,
                            ),
                          ),
                          BlocConsumer<SignupBloc, SignupState>(
                            listener: (context, state) {
                              if (state is SignupNavigateToSigninActionState) {
                                Navigator.of(context).pop(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              return InkWell(
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 17,
                                  ),
                                ),
                                onTap: () {
                                  context.read<SignupBloc>().add(
                                    SignupNavigateToSigninActionEvent(),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}