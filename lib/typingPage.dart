import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'package:animated_background/animated_background.dart';

class TypePage extends StatefulWidget {
  @override
  State<TypePage> createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> with TickerProviderStateMixin {
  List _items = [];
  String typingText = "typing text here ...";
  String typed = "";
  String toBeTyped = "";
  FocusNode myFocusNode;

  int index = 0;
  var myTime = DateTime.now();
  int startTime = 0;
  double timeElapsed = 0.1;
  int textTyped = 0;
  double speed = 0;
  bool stopButton = false;
  String buttonText = "START";

  Future<void> loadAsset() async {
    final String response =
        await rootBundle.loadString('assets/eminem_lyrics.txt');
    var rng = new Random();
    int val = rng.nextInt(5000);
    _items = response.split('\n');
    setState(() {
      typingText = "";
      for (var i = 0; i < 4; i++) {
        typingText += _items[i + val];
        typingText += ' ';
      }
      toBeTyped = typingText;
    });
  }

  Future<void> showSpeed(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Finished'),
            content: Text('Your Typing Speed is ${speed.round()}'),
          );
        });
  }

  //timer
  int _counter = 0;
  StreamController<int> _events;

  //text form field
  final myController = TextEditingController();
  String myText = "sahaj";

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    _events = new StreamController<int>();
    _events.add(5);
  }

  Timer _timer;

  void _startTimer() {
    _counter = 5;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //setState(() {
      (_counter > 0) ? _counter-- : _timer.cancel();
      //});
      _events.add(_counter);
    });
  }

  void alertD(BuildContext ctx) {
    var alert = AlertDialog(
      content: StreamBuilder<int>(
        stream: _events.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            child: Text('${snapshot.data.toString()}'),
          );
        },
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (BuildContext c) {
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
            myTime = DateTime.now();
          });
          return alert;
        });
  }

  //typing speed
  void mySpeed(String myText, BuildContext context) {
    int len = myText.length;
    if (len <= 1) return;
    if (myText[len - 1] == ' ') {
      myController.text = "";
      String letter = myText.substring(0, len - 1);
      String orgLetter = "";
      int local = index;
      while (typingText[local] != ' ') {
        orgLetter += typingText[local];
        local++;
      }
      if (letter == orgLetter) {
        index = local + 1;
        setState(() {
          typed = typingText.substring(0, index);
          toBeTyped = typingText.substring(index, typingText.length);
        });
      }
      if (index >= typingText.length - 1) {
        setState(() {
          showSpeed(context);
        });
      }
    }
    timeElapsed = DateTime.now().difference(myTime).inSeconds / 1;
    setState(() {
      speed = (index * 12) / (timeElapsed + 0.0001);
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: AnimatedBackground(
        behaviour: RacingLinesBehaviour(
          direction: LineDirection.Ltr,
          numLines: 50,
        ),
        vsync: this,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 600) {
              return Stack(
                children: [
                  // _bgContainer(),
                  _wideContainer(),
                  _homeButton(),
                ],
              );
            } else {
              return Stack(
                children: [
                  // _bgContainer(),
                  _normalContainer(),
                  _homeButton(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _bgContainer() {
    return Container(
      child: SvgPicture.asset(
        'assets/desing_test_2.svg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _homeButton() {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.topLeft,
      child: ElevatedButton(
        child: Text(
          'Home',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.all(Colors.purpleAccent[400]),
        ),
      ),
    );
  }

  Widget _wideContainer() {
    return Center(
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  heightFactor: 0.6,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(120, 189, 250, 221),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(150, 37, 148, 81),
                                height: 1.5),
                            //text: 'typing text here ...',
                            children: [
                              TextSpan(
                                text: typed,
                                style: TextStyle(
                                  color: Color.fromARGB(200, 30, 62, 228),
                                  shadows: <Shadow>[
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.blue,
                                    ),
                                    Shadow(
                                      blurRadius: 8.0,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                              TextSpan(text: toBeTyped),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 0.3,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      focusNode: myFocusNode,
                      controller: myController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        startTime = myTime.millisecond;
                        mySpeed(text, context);
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                style: ButtonStyle(
                  alignment: Alignment.center,
                  shadowColor: MaterialStateProperty.all(Colors.blue),
                  padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                ),
                clipBehavior: Clip.hardEdge,
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (stopButton == false) {
                    loadAsset();
                    _startTimer();
                    alertD(context);
                    myFocusNode.requestFocus();
                    stopButton = true;
                    setState(() {
                      buttonText = 'NEW GAME';
                    });
                  } else {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TypePage()));
                  }
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: FractionallySizedBox(
                  widthFactor: 0.2,
                  heightFactor: 0.6,
                  child: Center(
                    child: Card(
                      elevation: 20,
                      color: Colors.purpleAccent,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                              'Typing Speed ',
                              style: TextStyle(color: Colors.white),
                            )),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                                child: Text(
                              '${speed.round()}',
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _normalContainer() {
    return Center(
      child: Container(
        width: 600,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  heightFactor: 0.6,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(120, 189, 250, 221),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(150, 37, 148, 81),
                                height: 1.5),
                            //text: 'typing text here ...',
                            children: [
                              TextSpan(
                                text: typed,
                                style: TextStyle(
                                  color: Color.fromARGB(200, 30, 62, 228),
                                  shadows: <Shadow>[
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.blue,
                                    ),
                                    Shadow(
                                      blurRadius: 8.0,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                              TextSpan(text: toBeTyped),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 0.3,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      focusNode: myFocusNode,
                      controller: myController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        startTime = myTime.millisecond;
                        mySpeed(text, context);
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                style: ButtonStyle(
                  alignment: Alignment.center,
                  shadowColor: MaterialStateProperty.all(Colors.blue),
                  padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                ),
                clipBehavior: Clip.hardEdge,
                child: Text(
                  'START',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (stopButton == false) {
                    loadAsset();
                    _startTimer();
                    alertD(context);
                    myFocusNode.requestFocus();
                    stopButton = true;
                    setState(() {
                      buttonText = 'NEW GAME';
                    });
                  } else {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TypePage()));
                  }
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: FractionallySizedBox(
                  widthFactor: 0.3,
                  child: Center(
                    child: Card(
                      elevation: 20,
                      color: Colors.purpleAccent,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(bottom: 5, top: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                              'Typing Speed ',
                              style: TextStyle(color: Colors.white),
                            )),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                                child: Text(
                              '${speed.round()}',
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
