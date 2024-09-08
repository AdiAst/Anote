import 'package:anote/database/catatan_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Kelas `CatatanService` bertanggung jawab untuk mengelola koneksi database
class CatatanService {
  Database? _database;

  /// Getter untuk mengakses database. Jika database belum ada, 
  /// maka akan diinisialisasi terlebih dahulu.
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  /// Mendapatkan path dari lokasi database di perangkat.
  Future<String> get lokasi async {
    const name = 'catatan.db'; 
    final path = await getDatabasesPath(); // Mendapatkan path direktori database.
    return join(path, name);
  }

  /// Inisialisasi database jika belum tersedia.
  Future<Database> _initialize() async {
    final path = await lokasi;
    // Membuka atau membuat database dengan path yang didapatkan.
    var database = await openDatabase(
      path,
      version: 1, 
      onCreate: create, 
      singleInstance: true, 
    );
    return database;
  }
  /// Menjalankan proses pembuatan tabel melalui `CatatanDB`.
  Future<void> create(Database database, int version) async =>
      await CatatanDB().create(database);
}
