

class ModelCatatan{
  final int id;
  final String judul;
  final String isi;

  final String createdAt;
  final String? updatedAt;

  ModelCatatan({
    required this.id, 
    required this.judul,
    required this.isi,
    required this.createdAt,
    this.updatedAt
  });

  factory ModelCatatan.fromSqfliteDatabase(Map<String,dynamic> map)=> ModelCatatan(
    id: map['id']?.toInt() ?? 0, 
    judul: map['judul'] ?? '', 
    isi: map['isi'] ?? '', 
    createdAt: DateTime.fromMicrosecondsSinceEpoch(map['created_at']).toIso8601String(),
    updatedAt: map['updated_at'] == null ? null : DateTime.fromMicrosecondsSinceEpoch(map['updated_at']).toIso8601String(),
    );
}