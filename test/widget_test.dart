import 'package:anote/widget/kartu_catatan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test halaman utama", () {
    testWidgets('Judul catatan di tampilkan', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: KartuCatatan(id: 1,judulCatatan: "Catatan1",), 
        ),
      );
      await tester.pump(); 
      await tester.pump(const Duration(seconds: 1)); 
      expect(find.text('Catatan1'), findsOneWidget);
    });
  });
}
