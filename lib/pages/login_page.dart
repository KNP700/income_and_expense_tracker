import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/data/repositories/ledger_repository.dart';
import 'package:income_and_expense_tracker/pages/create_acc_page.dart';
import 'package:income_and_expense_tracker/pages/forgot_page.dart';
import 'package:income_and_expense_tracker/pages/login_with_mobile_page.dart';
import '../View/login/login_bloc.dart';
import '../data/repositories/auth_repository.dart';
import 'navigationBottomPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
      },
      child: BlocProvider(
        create: (context) => LoginBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          body: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is LoginSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Syncing your data..."),
                    backgroundColor: Colors.blue,
                    duration: Duration(seconds: 1),
                  ),
                );

                context.read<LedgerRepository>().syncDataFromCloud().then((_) {
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Navigationbottompage(),
                      ),
                    );
                  }
                });
              }
            },
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Welcome',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
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
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'name@example.com',
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
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: '**********',
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
                                    builder: (context) => const ForgotPage(),
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
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          bool isLoading = state is LoginLoadingState;
                          return InkWell(
                            onTap: isLoading
                                ? null
                                : () {
                              final email = _emailController.text.trim();
                              final password =
                              _passwordController.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Please enter both email and password"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              context.read<LoginBloc>().add(
                                LoginSubmittedEvent(
                                  email: email,
                                  password: password,
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: isLoading
                                        ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                        : const Text(
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
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<LoginBloc>()
                                  .add(GoogleSignInEvent());
                            },
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
                                const Text(
                                  "Google",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icon/apple_icon.png',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 10),
                                Center(
                                  child: Text(
                                    "Apple",
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
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
                              return ElevatedButton(
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                    LoginWithMobileToMobileEvent(),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icon/phone_icon.png',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(width: 10),
                                    Center(
                                      child: Text(
                                        "Login with Mobile",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
                                  fontSize: 17,
                                ),
                              ),
                              BlocConsumer<LoginBloc, LoginState>(
                                listener: (context, state) {
                                  if (state
                                  is LoginNavigateToSignupActionState) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const CreateAccPage(),
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return InkWell(
                                    child: const Text(
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