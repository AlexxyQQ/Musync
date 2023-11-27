import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    // Open Hive Boxes
    await hiveOpen('settings');
    await hiveOpen('users');
    await hiveOpen('uploads');
    await hiveOpen('songs');
    // Music Hive
    // await MusicHiveDataSourse().init();
  }

  /// Open Hive Boxes
  /// Provide a {$boxName} to open, if it fails to open, it will try again
  Future<void> hiveOpen(String boxName) async {
    await Hive.openBox(boxName).onError(
      (error, stackTrace) async {
        await Hive.openBox(boxName);
        throw 'Failed to open $boxName Box\nError: $error';
      },
    );
  }
}
