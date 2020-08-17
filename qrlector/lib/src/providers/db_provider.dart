

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qrlector/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBProvider{

  static Database _dataBase;
  static final DBProvider db = DBProvider._();

  DBProvider._();

 Future<Database> get database async {
    if(_dataBase!=null)
    return _dataBase;
    
    _dataBase= await initDB();
    return _dataBase;

  }
  initDB() async{

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path,"ScansDB.db" );

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {
      await db.execute(
          "Create table Scans (id INTEGER PRIMARY KEY, tipo TEXT, valor TEXT)"
      ) ;      
      }
    );
  }

  /*nuevoScanRaw(ScanModel nuevoScan) async{

    final db = await database;
    final res = await db.rawInsert(
        "insert into Scans (id,tipo,valor) "
        "values(${nuevoScan.id},'${nuevoScan.tipo}','${nuevoScan.valor}')"
    );

  }*/






}