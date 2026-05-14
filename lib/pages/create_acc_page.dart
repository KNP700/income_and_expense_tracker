import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/View/createAccPage/create_acc_page_bloc.dart';
import 'package:income_and_expense_tracker/data/repositories/auth_repository.dart';
import 'package:income_and_expense_tracker/pages/home_page.dart';
import 'package:income_and_expense_tracker/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NavigationBottomPage.dart';

class CreateAccPage extends StatefulWidget {
  const CreateAccPage({super.key});

  @override
  State<CreateAccPage> createState() => _CreateAccPageState();
}

class _CreateAccPageState extends State<CreateAccPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }

  Future<void> _loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('user_email') ?? '';
    if (!mounted) return;
    setState(() {
      _emailController.text = savedEmail;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateAccPageBloc(authRepository: AuthRepository()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      " Create Account",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "  Join us to start tracking your finances.",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: const Color(0xFF223143),
                          backgroundImage: const NetworkImage(
                            'assets/icon/my_image.png',
                          ),
                          child: const Text(
                            'K',
                            style: TextStyle(fontSize: 40),
                          ),
                          onBackgroundImageError: (exception, stackTrace) {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Email Address",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 18),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'name@example.com',
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white54 : Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "FIRST NAME",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _firstNameController,
                              style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 18),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                filled: true,
                                // fillColor: const Color(0XFF1c304a),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'First name',
                                hintStyle:  TextStyle(
                                  color: isDarkMode ? Colors.white54 : Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LAST NAME',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _lastNameController,
                              style: TextStyle(
                                color: isDarkMode ? Colors.white: Colors.black,
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'Last name',
                                hintStyle: TextStyle(
                                  color: isDarkMode ? Colors.white54 : Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'PASSWORD',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(
                        color: isDarkMode? Colors.white: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      filled: true,
                      // fillColor: const Color(0XFF1c304a),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: '*********',
                      hintStyle:  TextStyle(
                        color: isDarkMode? Colors.white54 : Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'CONFIRM PASSWORD',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white54: Colors.grey, fontSize: 16,),
                      decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_clock),
                      filled: true,
                      // fillColor: const Color(0XFF1c304a),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: '*********',
                      hintStyle: TextStyle(
                        color: isDarkMode? Colors.white54: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  BlocConsumer<CreateAccPageBloc, CreateAccPageState>(
                    listener: (context, state) {
                      if (state is CreateAccSuccessState) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      }
                      if (state is CreateAccErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Builder(
                        builder: (context) {
                          return InkWell(
                            onTap: () {
                              context.read<CreateAccPageBloc>().add(
                                    CreateAccDetailsSubmitted(
                                      email: _emailController.text.trim(),
                                      firstName:
                                          _firstNameController.text.trim(),
                                      lastName: _lastNameController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Sign Up",
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
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            fontSize: 17),
                      ),
                      BlocConsumer<CreateAccPageBloc, CreateAccPageState>(
                        listener: (context, state) {
                          if (state is ContinueCreateAccToSignIn2State) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return InkWell(
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              context.read<CreateAccPageBloc>().add(
                                    ContinueCreateAccToSignIn2Event(),
                                  );
                            },
                          );
                        },
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
