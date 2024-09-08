

import 'package:anote/database/catatan_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CatatanService{
  Database? _database;

  Future<Database> get database async{
    if (_database != null){
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get lokasi async{
    const name = 'catatan.db';
    final path = await getDatabasesPath();
    return join(path,name); 
  }

  Future<Database> _initialize() async{
    final path = await lokasi;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  Future<void> create(Database database,int version) async=>
    await CatatanDB().create(database);
  
}