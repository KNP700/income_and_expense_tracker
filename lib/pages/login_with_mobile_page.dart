import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/View/loginWithMobile/login_with_mobile_page_bloc.dart';
import 'package:income_and_expense_tracker/pages/mobile_otp_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../View/forgotPage/forgot_page_bloc.dart';
import 'NavigationBottomPage.dart';

class LoginWithMobilePage extends StatelessWidget {
  LoginWithMobilePage({super.key});

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginWithMobilePageBloc(),
      child: Scaffold(
        backgroundColor: Theme
        .of(context)
        .scaffoldBackgroundColor,

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
                    'Login with mobile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter your mobile number to receive a verification code',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 23),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    ' Mobile Number',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _phoneController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone_android),
                      filled: true,
                      fillColor: const Color(0XFF1c304a),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: '+94*********',
                      hintStyle: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  BlocConsumer<LoginWithMobilePageBloc, LoginWithMobilePageState>(
                    listener: (context, state) {
                      if (state is MobilePageToOtpState) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MobileOtpPage(
                                verificationId: state.verificationId),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return InkWell(
                        onTap: () async {
                          final phone = _phoneController.text.trim();

                          bool isValid =
                          RegExp(r"^\+[1-9]\d{10,14}$").hasMatch(phone);

                          if (isValid) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('phone_number', phone);

                            context.read<LoginWithMobilePageBloc>().add(
                              PhoneNumberSubmitted(phone ),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Check Your phone to Get OTP!")),
                            );

                            context.read<LoginWithMobilePageBloc>().add(
                              MobilePageToOtpEvent(),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Enter Valid Number !")),
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
                              Center(
                                child: Text(
                                  "Send Code",
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
                  const SizedBox(height: 370),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Login with your Email ! ",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 17,
                            ),
                          ),
                          //here
                          BlocConsumer<LoginWithMobilePageBloc,
                              LoginWithMobilePageState>(
                            listener: (context, state) {
                              if (state
                              is ForgotPasswordNavigateToSigninActionState) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Navigationbottompage(),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              return InkWell(
                                child: const Text(
                                  " Log In",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 17,
                                  ),
                                ),
                                onTap: () {
                                  context.read<LoginWithMobilePageBloc>().add(
                                    ForgotPasswordNavigateToSigninActionEvent() as LoginWithMobilePageEvent,
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