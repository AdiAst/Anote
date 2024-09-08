import 'package:anote/model/interface_catatan.dart';

class ModelCatatan implements ICatatan {
  @override
  final int id;
  @override
  final String judul;
  @override
  final String isi;

  /// Tanggal pembuatan catatan (dalam format ISO 8601).
  @override
  final String createdAt;

  /// Tanggal pembaruan catatan, jika ada (dalam format ISO 8601).
  @override
  final String? updatedAt;

  /// Konstruktor untuk membuat objek `ModelCatatan`.
  ModelCatatan({
    required this.id,
    required this.judul,
    required this.isi,
    required this.createdAt,
    this.updatedAt,
  });

  /// Factory method untuk membuat objek `ModelCatatan` dari map
  /// yang diambil dari database SQLite.
  factory ModelCatatan.fromSqfliteDatabase(Map<String, dynamic> map) =>
      ModelCatatan(
        id: map['id']?.toInt() ?? 0,
        judul: map['judul'] ?? '',
        isi: map['isi'] ?? '',
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] * 1000)
            .toIso8601String(),
        updatedAt: map['updated_at'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['updated_at'] * 1000)
                .toIso8601String(),
      );

  /// Method untuk mengubah objek menjadi bentuk map, sesuai dengan struktur database.
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'isi': isi,
      'created_at': DateTime.parse(createdAt).millisecondsSinceEpoch ~/ 1000,
      'updated_at': updatedAt == null
          ? null
          : DateTime.parse(updatedAt!).millisecondsSinceEpoch ~/ 1000,
    };
  }
}
