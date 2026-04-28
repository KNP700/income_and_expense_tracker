import 'package:isar/isar.dart';

class TransactionModel {
  Id id=Isar.autoIncrement;

  late int ledgerId;
  late double amount;
  late bool isExpense;
  late String paidBy;
  late String category;
  late String notes;
  late DateTime date;

}