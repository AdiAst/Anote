abstract class ICatatan {
  int get id;
  String get judul;
  String get isi;
  String get createdAt;
  String? get updatedAt;

  /// Method untuk mengubah objek menjadi bentuk map.
  Map<String, dynamic> toMap();
}