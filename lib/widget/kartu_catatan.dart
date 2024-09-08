import 'package:anote/database/catatan_db.dart';
import 'package:anote/widget/catatan.dart';
import 'package:anote/widget/home.dart';
import 'package:flutter/material.dart';

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
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Catatan(idCatatan: id),
              ),
            );
          },
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
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.delete), 
                  onPressed: () {
                    CatatanDB().delete(id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage(title: 'ANOTE'),
                        ),
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
