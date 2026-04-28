import 'package:isar_community/isar.dart';

part 'transaction_model.g.dart';

@collection
class TransactionModel {
  Id id = Isar.autoIncrement;

  late int ledgerId;
  late double amount;
  late bool isExpense;
  late String paidBy;
  late String category;
  late String paymentMethod;
  String? notes;
  late DateTime date;
}