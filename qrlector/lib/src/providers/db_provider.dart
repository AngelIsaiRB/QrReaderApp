

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qrlector/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
export 'package:qrlector/src/models/scan_model.dart';

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


  nuevoScan(ScanModel nuevoScan) async{ // insert
    final db = await database;
    final res = await  db.insert("Scans", nuevoScan.toJson());
    return res;
  }

  //select
  Future<ScanModel> getScanId(int id) async {
    final db= await database;
    final res =await db.query("Scans",where: "id=?", whereArgs: [id] );
    return res.isNotEmpty ? ScanModel.fromJson(res.first):null;
  }
Future<List<ScanModel>> getTodosScans() async{
   /* List<ScanModel> lista=[];
    for (var item in res) {
      lista.add(ScanModel.fromJson(item));
    }*/
    final db = await database;
    final res =await db.query("Scans");
    List<ScanModel> list= res.isNotEmpty ? 
                           res.map((item) => ScanModel.fromJson(item))
                           .toList() 
                           : [] ;
    return list;

  }
  
  Future<List<ScanModel>> getScansPorTipo(String tipo) async{   
    final db = await database;
    final res =await db.query("SELECT * FROM Scans WHERE tipo='$tipo'");
    List<ScanModel> list= res.isNotEmpty ? 
                           res.map((item) => ScanModel.fromJson(item))
                           .toList() 
                           : [] ;
    return list;

  }

  Future<int> updateSacan(ScanModel sm) async{
    final db =  await database;
    final res = await db.update("Scans", sm.toJson() , where:"id=?", whereArgs: [sm.id]  );
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res= await db.delete("Scans", where: "id=?", whereArgs: [id]);
    return res;

  }
  Future<int> deleteAll() async {
    final db = await database;
    final res= await db.delete("Scans",);
    return res;

  }




}