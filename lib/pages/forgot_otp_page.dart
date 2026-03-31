import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/View/signup/signup_bloc.dart';
import 'package:income_and_expense_tracker/pages/reset_password_page.dart';

import '../View/forgotOtpPage/forgot_otp_page_bloc.dart';
import '../View/signupOtpPage/signup_otp_page_bloc.dart';
import 'create_acc_page.dart';

class ForgotOtpPage extends StatelessWidget {
  const ForgotOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotOtpPageBloc(),
      child: Scaffold(
        backgroundColor: const Color(0XFF0a1625),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
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
                      // const SizedBox(height: 50),
                      const Text(
                        'Vertify Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/email_logo.png',
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Enter Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "We've sent a 6-digit vertification code to your email ",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                  ),

                  const SizedBox(height: 25),

                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0XFF1c304a),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: "OTP Number",
                      hintStyle: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  BlocConsumer<ForgotOtpPageBloc, ForgotOtpPageState>(
                    listener: (context, state) {
                      if (state is ForgotOtpPageToResetState) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordPage(),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          context.read<ForgotOtpPageBloc>().  add(
                            ForgotOtpPageToResetEvent(),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Vertify & Continue",
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

                  SizedBox(height: 150),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        "Didn't receive the code?",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),

                      InkWell(
                        child: const Text(
                          "Resend Code",
                          style: TextStyle(color: Colors.blue, fontSize: 17),
                        ),
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

    // TODO: implement build
    throw UnimplementedError();
  }
}
