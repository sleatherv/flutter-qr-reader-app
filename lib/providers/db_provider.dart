
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database?> get dababase async {
    _database ??= await initDB();
    return _database;
  }

  Future<Database> initDB() async{
    //Path where we will store the database
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ScansDB.db'); //.db extension is very important
    print(path);
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

}