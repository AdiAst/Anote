import 'package:flutter/material.dart';


class Catatan extends StatelessWidget {
  const Catatan({super.key, required this.catatan});
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
