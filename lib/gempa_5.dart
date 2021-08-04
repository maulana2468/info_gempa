import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gempa_cuaca_app/gempa_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SecondPage();
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F35C),
        title: Text(
          "Gempabumi M 5.0+",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
