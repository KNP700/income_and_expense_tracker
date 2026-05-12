import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../View/ledgerPage/ledger_page_bloc.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LedgerPageBloc(),
      child:  Scaffold(
        backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
        body: Center(
          child: Text("Report Page", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
