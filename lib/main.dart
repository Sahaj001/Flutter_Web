import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:typing_class/register.dart';
import 'package:typing_class/typingPage.dart';
// import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'mainPage1.dart';
// import 'package:typing_class/page1.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: Register(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

var texts = "a set of entities and create a generalized entity from it ";
var textLen = texts.length;

class _MyAppState extends State<MyApp> {
  TextEditingController _nameController = TextEditingController();
  String _typingSpeed = "---";
  var typedText = "";
  Color _color = Colors.green;
  var startTime = 0 * DateTime.now().millisecondsSinceEpoch;
  var id = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'start typing',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('How Fast can you Type ??'),
        ),
        body: Container(
          child: Text('hello MyApp'),
        ),
      ),
    );
  }
}
