import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/View/createLedgerPage/create_ledger_page_bloc.dart';

class CreateLedgerPage extends StatelessWidget {
  const CreateLedgerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => CreateLedgerPageBloc(),
      child: const Scaffold(
        backgroundColor: Color(0XFF0a1625),
      ),
    );
  }
}
