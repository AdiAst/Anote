import 'package:anote/widget/catatan.dart';
import 'package:flutter/material.dart';

class KartuCatatan extends StatelessWidget {
  const KartuCatatan({super.key, required this.judulCatatan});

  final String judulCatatan;

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
            MaterialPageRoute(builder: (context) => Catatan(catatan: judulCatatan,)),
          );
          },
          child: SizedBox(
            width: 350,
            height: 100,
            child: Center(
              child: Text(
                judulCatatan,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
