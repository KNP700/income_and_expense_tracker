import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/View/mobileOtpPage/mobile_otp_page_bloc.dart';

class MobileOtpPage extends StatelessWidget {
  const MobileOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                  ),
                ),
              )
          ),
        )
    );
  }
}
