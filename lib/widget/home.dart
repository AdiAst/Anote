import 'dart:async';

import 'package:anote/database/catatan_db.dart';
import 'package:anote/model/model_catatan.dart';
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
    _ambilCatatan();
  }

  void _ambilCatatan() {
    setState(() {
      daftarCatatan = dbCatatan.getAll();
    });
  }

  void _tambahCatatan() {
    dbCatatan.insert(judul: "ipsum", isi: "ipsum");
    if(!mounted) return;
    _ambilCatatan();
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notes available.'));
          } else {
            final catatanList = snapshot.data!;
            return ListView.builder(
              itemCount: catatanList.length,
              itemBuilder: (context, index) {
                final catatan = catatanList[index];
                return KartuCatatan(judulCatatan: catatan.judul);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahCatatan,
        tooltip: 'Tambah',
        child: const Icon(Icons.add),
      ),
    );
  }
}
