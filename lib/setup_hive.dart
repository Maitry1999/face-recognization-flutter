import 'package:attandence_system/infrastructure/account/account_entity.dart';
import 'package:attandence_system/infrastructure/core/network/hive_box_names.dart';
import 'package:attandence_system/infrastructure/punch_in_out/punch_in_out_entity.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> setupHive() async {
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(AccountEntityAdapter());
  Hive.registerAdapter(PunchInOutRecordAdapter());

  await Hive.openBox(BoxNames.settingsBox);
  await Hive.openBox(BoxNames.punchBox);
  await Hive.openBox(BoxNames.lastPunchDateBox);
  await Hive.openBox(BoxNames.historyBox);
  await Hive.openBox<AccountEntity>(BoxNames.currentUser);
}
