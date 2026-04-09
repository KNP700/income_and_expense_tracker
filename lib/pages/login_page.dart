import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/View/home/home_bloc.dart';
import 'package:income_and_expense_tracker/View/home/home_bloc.dart';
import 'package:income_and_expense_tracker/pages/forgot_page.dart';
import 'package:income_and_expense_tracker/pages/home_page.dart';
import 'package:income_and_expense_tracker/pages/login_with_mobile_page.dart';
import 'package:income_and_expense_tracker/pages/signup_page.dart';
import '../View/login/login_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data/repositories/auth_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevents back navigation
      onPopInvoked: (didPop) {
        if (didPop) return;
        // Optional: show dialog or call bloc to handle back attempt
      },
      child: BlocProvider(
        create: (context) =>
            LoginBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),

        child: Scaffold(
          backgroundColor: const Color(0XFF0a1625),
          body: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              // if (state is LoginFailed) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text(state.message),
              //       backgroundColor: Colors.red,
              //     ),
              //   );
              // }
            },
            child: SafeArea(
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
                      const SizedBox(height: 10),
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 0),

                      const Text(
                        'Please Sign to track your expenses',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 22),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Email Address',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          filled: true,
                          fillColor: Color(0XFF1c304a),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: 'name@example.com',
                          hintStyle: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0XFF1c304a),

                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: '***********',
                          hintStyle: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state is LoginNavigateToForgotActionState) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPage(),
                                  ),
                                );
                              }
                            },

                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  context.read<LoginBloc>().add(
                                    LoginNavigateToForgotActionEvent(),
                                  );
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginNavigateIntoHomeState) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              context.read<LoginBloc>().add(
                                LoginNavigateIntoHomeEvent(),
                              );
                            },

                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 15),

                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      Column(
                        spacing: 20,
                        children: [
                          // const SizedBox(height: 25),
                          BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state is LoginSuccessState) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              } else if (state is LoginFailureState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.error),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      duration: const Duration(seconds: 3),
                                    ),
                                );
                              }
                            },
                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  context.read<LoginBloc>().add(
                                      GoogleSignInEvent());
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
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
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(width: 10),
                                      const Center(
                                        child: Text(
                                          "Google",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Color(0XFF1c304a),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icon/apple_icon.png',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.contain,
                                ),
                                Center(
                                  child: Text(
                                    " Apple",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state is LoginWithMobileToMobileState) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => LoginWithMobilePage(),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  context.read<LoginBloc>().add(
                                    LoginWithMobileToMobileEvent(),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Color(0XFF1c304a),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/icon/phone_icon.png',
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.contain,
                                      ),
                                      Center(
                                        child: Text(
                                          " Login with Mobile",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),

                              // BlocListener(listener: (context, state) {
                              //
                              // },child: ,),
                              BlocConsumer<LoginBloc, LoginState>(
                                listener: (context, state) {
                                  if (state
                                  is LoginNavigateToSignupActionState) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SignupPage(),
                                      ),
                                    );
                                  }
                                },

                                builder: (context, state) {
                                  return InkWell(
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 17,
                                      ),
                                    ),
                                    onTap: () {
                                      context.read<LoginBloc>().add(
                                        LoginNavigateToSignupActionEvent(),
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
        ),
      ),
    );
  }
}
