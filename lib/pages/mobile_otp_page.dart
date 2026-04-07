import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/View/mobileOtpPage/mobile_otp_page_bloc.dart';
import 'package:income_and_expense_tracker/pages/home_page.dart';

class MobileOtpPage extends StatelessWidget {

   MobileOtpPage({super.key, required this.verificationId});
  final String verificationId;

  final _otpController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement buildF
    return BlocProvider(
        create: (context) => MobileOtpPageBloc(),
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
                        'Enter OTP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Enter the 4-digit code sent to your mobile number ',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 23),
                      ),
                      const SizedBox(height: 40),

                      TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone_android),
                          filled: true,
                          fillColor: const Color(0XFF1c304a),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: '0000',
                          hintStyle: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                          ),
                        ),
                      ),


                      const SizedBox(height:100),
                      BlocConsumer<MobileOtpPageBloc, MobileOtpPageState>(
                        listener: (context, state) {
                          if (state is AfterMobileOtpNavigationState) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              context.read<MobileOtpPageBloc>().add(
                                SignupVerifyOtpEvent(
                                  verificationId: verificationId,
                                  otpCode: _otpController.text,

                                ),
                              );
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
                                      "Vertify & Proceed",
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(
                            "Didn't receive the code?",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),

                          InkWell(
                            child: Text(
                              "Resend Code",
                              style: TextStyle(color: Colors.blue, fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ],

                  ),
                ),
              )
          ),
        )
    );
  }
}
