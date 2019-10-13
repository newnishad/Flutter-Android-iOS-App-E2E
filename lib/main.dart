import 'package:flutter/material.dart';
import './pages/search_page.dart';

void main() {
  return runApp(E2EDictionary());
}

class E2EDictionary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E2E Dictionary",
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.grey,
      ),
      home: SearchPage(),
    );
  }
}
