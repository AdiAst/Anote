import 'package:anote/database/service.dart';
import 'package:anote/model/model_catatan.dart';
import 'package:sqflite/sqflite.dart';

class CatatanDB {
  final String namaTabel = 'catatan';

  /// Membuat tabel catatan di database jika belum ada.
  Future<void> create(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS $namaTabel (
        "id" INTEGER NOT NULL,
        "judul" TEXT NOT NULL,
        "isi" TEXT NOT NULL,
        "created_at" INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS int)),
        "updated_at" INTEGER,
        PRIMARY KEY ("id" AUTOINCREMENT)
      );
    ''');
  }

  /// Menambahkan catatan baru ke dalam database.
  /// Mengembalikan ID catatan yang dimasukkan.
  Future<int> insert({required String judul, required String isi}) async {
    final database = await CatatanService().database;
    return await database.rawInsert(
      '''INSERT INTO $namaTabel (judul, isi, created_at) VALUES (?, ?, ?)''',
      [judul, isi, DateTime.now().millisecondsSinceEpoch],
    );
  }

  /// Mengambil semua catatan dari database, diurutkan berdasarkan 
  /// `updated_at` atau `created_at` jika `updated_at` tidak ada.
  Future<List<ModelCatatan>> getAll() async {
    final database = await CatatanService().database;
    final List<Map<String, dynamic>> catatan = await database.rawQuery(
      ''' SELECT * FROM $namaTabel ORDER BY COALESCE(updated_at, created_at) DESC; '''
    );
    return catatan.map((data) => ModelCatatan.fromSqfliteDatabase(data)).toList();
  }

  /// Mengambil catatan berdasarkan [id].
  Future<ModelCatatan> getById(int id) async {
    final database = await CatatanService().database;
    final List<Map<String, dynamic>> catatan = await database.rawQuery(
      ''' SELECT * FROM $namaTabel WHERE id = ? ''',
      [id],
    );
    return ModelCatatan.fromSqfliteDatabase(catatan.first);
  }

  /// Memperbarui catatan berdasarkan [id].
  /// Hanya data yang tidak null yang akan diperbarui.
  Future<int> update({required int id, String? judul, String? isi}) async {
    final database = await CatatanService().database;
    return await database.update(
      namaTabel,
      {
        if (judul != null) 'judul': judul,
        if (isi != null) 'isi': isi,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  /// Menghapus catatan berdasarkan [id].
  Future<void> delete(int id) async {
    final database = await CatatanService().database;
    await database.rawDelete(
      ''' DELETE FROM $namaTabel WHERE id = ? ''',
      [id],
    );
  }
}
