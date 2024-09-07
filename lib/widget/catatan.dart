import 'package:flutter/material.dart';


class Catatan extends StatelessWidget {
  const Catatan({Key? key, required this.catatan}) : super(key: key);
  final String catatan;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(catatan),
      ),
      body: const Text("lrom")
      
    );
  }
}
