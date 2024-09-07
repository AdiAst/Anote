import 'package:flutter/material.dart';
import 'package:anote/widget/kartu_catatan.dart';

import 'package:mysql_client/mysql_client.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<String> _catatanList = ["Catatan 1", "Catatan 2", "Catatan 3", "Catatan 4","Catatan 5", "Catatan 6", "Catatan 7", "Catatan 8"];
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _catatanList.length,
        itemBuilder: (context, index) {
          return KartuCatatan(judulCatatan: _catatanList[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
