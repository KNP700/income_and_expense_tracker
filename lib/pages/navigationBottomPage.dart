import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/pages/home_page.dart';
import 'package:income_and_expense_tracker/pages/ledger_page.dart';

import '../View/navigation/navigation_bloc.dart';

class Navigationbottompage extends StatelessWidget {
  const Navigationbottompage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pageList=[
      const HomePage(),
      const LedgerPage(),

    ];


    // TODO: implement build
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, TabNavigation>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0XFF0a1625),
            body: pageList[state.tabIndex],
            //swaping page remember kaveeeennn, its happening by indexing buttons

            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: const Color(0XFF0a1625),
              unselectedItemColor: Colors.blueGrey,
              selectedItemColor: Colors.white,
              showSelectedLabels: true,
              type: BottomNavigationBarType.fixed,
              currentIndex: state.tabIndex,
              onTap: (index) {
                context.read<NavigationBloc>().add(TabChange(tabIndex: index));
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  label: 'Ledger',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart),
                  label: 'Report',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
