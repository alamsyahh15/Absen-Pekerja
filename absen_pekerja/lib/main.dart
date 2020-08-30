import 'package:absen_pekerja/screen/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.green,
      primarySwatch: Colors.green,
    ),
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}
