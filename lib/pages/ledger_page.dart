import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../View/ledgerPage/ledger_page_bloc.dart';

class LedgerPage extends StatelessWidget {
  const LedgerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LedgerPageBloc(),
      child: const Scaffold(
        backgroundColor: Color(0XFF0a1625),
        body: Center(
          child: Text("Ledger Content", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
