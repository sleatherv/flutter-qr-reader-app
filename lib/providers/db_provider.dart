
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider{
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  Future<Database> initDB() async{
    //Path where we will store the database
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ScansDB.db'); //.db extension is very important
   // print(path);
    //Create the database
    return await openDatabase(
      path,
      version: 1, //Remember to increase the version of the database when you make any changes
      onOpen: (db) {},
      onCreate: (Database db, int version) async{
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          );
        ''');
      },
    );
  }

  Future<int> newScanRaw(ScanModel newScan) async{
    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;
    // Verify database
    final db = await database;

    final res = await db!.rawInsert('''
        INSERT INTO Scans(id, type, value)
          VALUES($id, '$type', '$value')
      ''');

    return res;
  }

  Future<int>newSan(ScanModel newScan) async{
    final db = await database;
    final res = await db!.insert('Scans', newScan.toMap());
    //Last inserted item ID
    return res;
  }
}