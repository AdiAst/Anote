

import 'package:anote/database/service.dart';
import 'package:anote/model/model_catatan.dart';
import 'package:sqflite/sqflite.dart';

class CatatanDB{
  final nama_tabel = 'catatan';

  Future<void> create(Database database)async{
    await database.execute("""
      CREATE TABLE IF NOT EXISTS $nama_tabel (
        "id" INTEGER NOT NULL,
        "judul" TEXT NOT NULL,
        "isi" TEXT NOT NULL,
        "created_at" INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS int)),
        "updated_at" INTEGER,
        PRIMARY KEY ("id" AUTOINCREMENT)
      );
    """);
  }

  Future<int> insert({required String judul, required String isi}) async {
    final database = await CatatanService().database;

    return await database.rawInsert(
      '''INSERT INTO $nama_tabel (judul, isi, created_at) VALUES (?, ?, ?)''',
      [judul, isi, DateTime.now().millisecondsSinceEpoch],
    );
  }

  Future<List<ModelCatatan>> getAll() async{
    final database = await CatatanService().database;
    final catatan = await database.rawQuery(''' SELECT * FROM $nama_tabel ORDER BY COALESCE(updated_at,created_at) DESC; ''');
    return catatan.map((catatan) => ModelCatatan.fromSqfliteDatabase(catatan)).toList();
  }

  Future<ModelCatatan> getById(int id) async{
    final database = await CatatanService().database;
    final catatan = await database.rawQuery(''' SELECT * FROM $nama_tabel WHERE id = ? ''',[id]);
    return ModelCatatan.fromSqfliteDatabase(catatan.first);
  }

  Future<int> update({required int id, String? judul, String? isi}) async{
    final database = await CatatanService().database;
    return await database.update(
      nama_tabel,
      {
        if (judul != null) 'judul':judul,
        if (isi != null) 'isi':isi,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id=?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
      
    );
  }
  Future<void> delete(int id) async{
    final database = await CatatanService().database;
    await database.rawDelete(''' DELETE FROM $nama_tabel WHERE id = ? ''',[id]);
  }
}