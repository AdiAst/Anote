import 'package:anote/database/catatan_db.dart';
import 'package:anote/widget/catatan.dart';
import 'package:anote/widget/home.dart';
import 'package:flutter/material.dart';

/// Widget untuk menampilkan catatan dalam bentuk kartu.
/// Kartu ini menampilkan [judulCatatan] dan memiliki fungsi
/// untuk menampilkan detail catatan saat di klik dan menghapusnya.
class KartuCatatan extends StatelessWidget {
  const KartuCatatan({
    super.key, 
    required this.judulCatatan, 
    required this.id,
  });

  final String judulCatatan;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          // Warna saat kartu ditekan.
          splashColor: Colors.blue.withAlpha(30),

          // Aksi saat kartu ditekan, menampilkan detail catatan.
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Catatan(idCatatan: id),
              ),
            );
          },

          // Tampilan kartu catatan.
          child: Stack(
            children: [
              SizedBox(
                width: 550,
                height: 100,
                child: Center(
                  child: Text(
                    judulCatatan,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              
              // Tombol hapus yang terletak di pojok kanan atas kartu.
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.delete),

                  // Aksi saat tombol hapus ditekan.
                  onPressed: () async {
                    // Hapus catatan dari database.
                    await CatatanDB().delete(id);
                    
                    // Kembali ke halaman utama setelah penghapusan catatan.
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: 'ANOTE'),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
