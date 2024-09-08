import 'dart:async';
import 'package:anote/database/catatan_db.dart';
import 'package:anote/model/model_catatan.dart';
import 'package:anote/widget/catatan.dart';
import 'package:flutter/material.dart';
import 'package:anote/widget/kartu_catatan.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<ModelCatatan>>? daftarCatatan;
  final dbCatatan = CatatanDB();

  @override
  void initState() {
    super.initState();
    ambilCatatan();
  }

  /// Mengambil daftar catatan dari database dan memperbarui state.
  void ambilCatatan() {
    setState(() {
      daftarCatatan = dbCatatan.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<ModelCatatan>>(
        future: daftarCatatan,
        builder: (context, snapshot) {
          // Indikator loading.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          // Jika ada error, tampilkan pesan error.
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } 
          // Jika data kosong atau tidak ada catatan, tampilkan pesan kosong.
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada catatan.'));
          } 
          // Jika data ada, tampilkan daftar catatan.
          else {
            final catatanList = snapshot.data!;
            return ListView.builder(
              itemCount: catatanList.length,
              itemBuilder: (context, index) {
                final catatan = catatanList[index];
                return KartuCatatan(
                  judulCatatan: catatan.judul,
                  id: catatan.id,
                );
              },
            );
          }
        },
      ),
      // Tombol aksi untuk menambahkan catatan baru.
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const Catatan())
          );
        },
        tooltip: 'Tambah',
        child: const Icon(Icons.add),
      ),
    );
  }
}
