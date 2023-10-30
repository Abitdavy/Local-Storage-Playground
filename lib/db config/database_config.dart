import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:realm/realm.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/realm/model_detail_realm.dart';
import 'package:test_app/realm/model_realm.dart';

class DatabaseConfig {

  //*Sqflite
  static Future<List<Map<String, dynamic>>> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "chinook.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e.toString());
      }

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "chinook.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
      print("Database created successfully");
    } else {
      print("Opening existing database");
    }

    // open the database
    var db = await openDatabase(
      path,
      version: 3,
      readOnly: false,
    );
    return db.query('albums');
  }

  static Future<void> copyDatabaseFileFromAssets() async {
    // Search and create db file destination folder if not exist
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final objectBoxDirectory =
        Directory(documentsDirectory.path + '/objectbox/');

    if (!objectBoxDirectory.existsSync()) {
      await objectBoxDirectory.create(recursive: true);
    }

    final dbFile = File(objectBoxDirectory.path + '/data.mdb');
    if (!dbFile.existsSync()) {
      // Get pre-populated db file.
      ByteData data = await rootBundle.load("assets/data.mdb");

      // Copying source data into destination file.
      await dbFile.writeAsBytes(data.buffer.asUint8List());
    }
  }
}
