import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

var texts = "a set of entities and create a generalized entity from it ";
var text_len = texts.length;

class _MyAppState extends State<MyApp> {
  TextEditingController _nameController = TextEditingController();
  var _typingSpeed = '---';
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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("../assets/images/fig1.jpg"),
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.dstATop),
            ),
          ),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.all(30),
                  width: 800,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.amber[200], width: 4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    texts,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                  )),
              Container(
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.all(30),
                  width: 800,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.amber[200], width: 4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    typedText,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blue),
                  )),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.amber[200], width: 4),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(30),
                width: 800,
                height: 100,
                margin: EdgeInsets.all(30),
                child: TextField(
                  onChanged: (text) {
                    int x = text.length; // length of text entered
                    if (text[x - 1] == " ") {
                      var flag = false;
                      var it = id;
                      for (var i = 0; i < x; i++) {
                        if (texts[i + id] != text[i]) {
                          flag = true;
                          break;
                        }
                      }
                      if (flag == false) {
                        setState(() {
                          typedText += text;
                        });
                        print('correct');
                        id += x;
                      } else {
                        print('wrong');
                        print(id);
                        print(it);
                      }
                      if (_nameController.text == text)
                        print(_nameController.text);
                      _nameController.text = "";
                    }
                    if (text_len == id) {
                      setState(() {
                        _color = Colors.red;
                      });
                    }
                    setState(() {
                      var newTime = DateTime.now().millisecondsSinceEpoch;
                      var timediff = (newTime - startTime) / (1000 * 60);
                      var speed = text_len / (5 * timediff);
                      int speedR = speed.round();
                      var display = "$speedR";
                      _typingSpeed = display;
                    });
                    print("typing over");
                  },
                  controller: _nameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'type here',
                  ),
                ),
              ),
              FlatButton(
                  onPressed: () {
                    typedText = "";
                    id = 0;
                    startTime = DateTime.now().millisecondsSinceEpoch;
                  },
                  color: Colors.green[200],
                  child: Text('Click here to start')),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.amber[200], width: 4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(30),
                  width: 800,
                  height: 200,
                  margin: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: FAProgressBar(
                          currentValue:
                              ((typedText.length * 100) / text_len).round(),
                          displayText: '%',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: FAProgressBar(
                          currentValue: ((typedText.length * 12000) /
                                  (DateTime.now().millisecondsSinceEpoch -
                                      startTime))
                              .round(),
                          displayText: 'wpm',
                        ),
                      ),
                    ],
                  )),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.amber[200], width: 4),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 200,
                height: 50,
                child: ElevatedButton(
                    child: const Text('Open route'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
