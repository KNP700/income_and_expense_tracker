import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/View/login/login_bloc.dart';
import 'package:income_and_expense_tracker/View/signup/signup_bloc.dart';
import 'package:income_and_expense_tracker/data/repositories/auth_repository.dart';
import 'package:income_and_expense_tracker/pages/login_page.dart';
import 'package:income_and_expense_tracker/pages/signup_otp_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../View/signupOtpPage/signup_otp_page_bloc.dart';
import 'create_acc_page.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final _emailController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(authRepository: AuthRepository()),
      child: Scaffold(
        backgroundColor: const Color(0XFF0a1625),
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
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
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
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      filled: true,
                      fillColor: const Color(0XFF1c304a),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'name@example.com',
                      hintStyle: const TextStyle(
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

                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return InkWell(
                        onTap: () async {
                          final email = _emailController.text.trim();

                          if (email.isNotEmpty && email.contains('@')) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('user_email', email);

                            context.read<SignupBloc>().add(
                                  EmailSubmitted(email),
                                );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Check your email for the verification link!")),
                            );
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
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
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
                      Container(
                        padding: const EdgeInsets.all(25),
                        width: 190,
                        decoration: BoxDecoration(
                          color: const Color(0XFF1c304a),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icon/google_icon.png',
                              width: 25,
                              height: 25,
                            ),
                            const Text(
                              ' Google',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      Container(
                        padding: const EdgeInsets.all(25),
                        width: 190,
                        decoration: BoxDecoration(
                          color: const Color(0XFF1c304a),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icon/apple_icon.png',
                              width: 25,
                              height: 25,
                            ),
                            const Text(
                              ' Apple',
                              style: TextStyle(
                                color: Colors.white,
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

                          //here
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
