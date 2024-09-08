import 'package:anote/database/catatan_db.dart';
import 'package:anote/model/model_catatan.dart';
import 'package:anote/widget/home.dart';
import 'package:flutter/material.dart';

/// Widget halaman catatan untuk membuat atau mengedit catatan.
class Catatan extends StatefulWidget {
  const Catatan({super.key, this.idCatatan});

  final int? idCatatan;

  @override
  State<Catatan> createState() => _CatatanState();
}

class _CatatanState extends State<Catatan> {
  final _formKey = GlobalKey<FormState>();
  final dbCatatan = CatatanDB();
  final judulController = TextEditingController();
  final isiController = TextEditingController();

  Future<ModelCatatan>? catatan;

  @override
  void initState() {
    super.initState();
    _ambilCatatan();
  }

  /// Mengambil catatan dari database jika [idCatatan] ada.
  void _ambilCatatan() {
    if (widget.idCatatan != null) {
      catatan = dbCatatan.getById(widget.idCatatan!);
      catatan!.then((value) {
        // Isi controller dengan data catatan yang diambil.
        judulController.text = value.judul;
        isiController.text = value.isi;
      });
    }
  }

  @override
  void dispose() {
    // Hapus controller saat widget dibuang untuk menghindari kebocoran memori.
    judulController.dispose();
    isiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Catatan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Input untuk judul catatan
              TextFormField(
                controller: judulController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: "Judul"),
              ),
              // Input untuk isi catatan
              TextFormField(
                controller: isiController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Isi catatan tidak boleh kosong';
                  }
                  return null;
                },
                decoration:
                    const InputDecoration(labelText: "Tulis catatan disini..."),
              ),
              Container(
                margin: const EdgeInsets.all(32),
                child: ElevatedButton(
                  // Aksi saat tombol simpan ditekan.
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Jika idCatatan null, simpan catatan baru.
                      if (widget.idCatatan == null) {
                        dbCatatan.insert(
                          judul: judulController.text,
                          isi: isiController.text,
                        );
                      } else {
                        // Jika tidak, perbarui catatan yang ada.
                        dbCatatan.update(
                          id: widget.idCatatan!,
                          judul: judulController.text,
                          isi: isiController.text,
                        );
                      }

                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data diproses')),
                      );

                      // Navigasi kembali ke halaman utama setelah simpan.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage(title: 'ANOTE'),
                        ),
                      );
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
