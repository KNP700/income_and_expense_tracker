import 'package:isar_community/isar.dart';

import '../../enum/enums.dart';

part 'ledger_model.g.dart';

@collection
class LedgerModel {
  Id id = Isar.autoIncrement;

    late String name;
    late String iconLabel;
    String? currency;
  @enumerated
  Status status = Status.pending;

  DateTime CreatedAt = DateTime.now();
  DateTime UpdatedAt = DateTime.now();

}