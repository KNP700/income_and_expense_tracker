import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../View/home/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (context) => HomeBloc(),
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