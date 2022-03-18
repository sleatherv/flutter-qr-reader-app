
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
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async{
    //Path where we will store the database
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ScansDB.db'); //.db extension is very important

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

  Future<ScanModel?> getScanById (int scanID)async{
    final db = await database;
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [scanID]); //whereArgs can be positional

    return res.isNotEmpty
          ? ScanModel.fromMap(res.first)
          : null;
  }
  
  Future<List<ScanModel>> getAllScans ()async{
    final db = await database;
    final res = await db!.query('Scans'); //whereArgs can be positional

    return res.isNotEmpty
          ? res.map((s) => ScanModel.fromMap(s)).toList()
          : [];
  }

  Future<List<ScanModel>> getScanByType (String type ) async{
    final db = await database;
    final res = await db!.rawQuery('''
      SELECT * FROM Scans WHERE type = '$type'
    ''');

    return res.isNotEmpty
          ? res.map((s) => ScanModel.fromMap(s)).toList()
          : [];
  }

  Future<int> updateScan (ScanModel updatedScan ) async{
    final db  = await database;
    final res = await db!.update('Scans', updatedScan.toMap(), where: 'id = ?', whereArgs: [updatedScan.id]); // !important: Don't forget where conditon

    return res;
  }

  Future<int> deleteScan (int scanID) async{
    final db = await database;

    final res = await db!.delete('Scans', where: 'id = ?',whereArgs: [scanID]);

    return res;
  }
  Future<int> deleteAllScans () async{
    final db = await database;

    final res = await db!.rawDelete('DELETE FROM Scans');

    return res;
  }
}