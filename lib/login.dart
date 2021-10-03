import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'mainPage1.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(children: <Widget>[
        Container(
          child: SvgPicture.asset(
            '/Users/sahajsingh/TypingClass/typing_class/assets/images/bg_fig_1.svg',
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.amber[200], width: 0),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.amber[100],
                          offset: Offset(8, 8),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                    width: 345,
                    child: Column(
                      children: [
                        Container(
                          width: 345,
                          height: 55,
                          child: Text(
                            'Welcome !',
                            style: const TextStyle(
                              fontSize: 38,
                              color: Color.fromRGBO(11, 212, 134, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        Container(
                          width: 345,
                          height: 90,
                          padding: EdgeInsets.all(20),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPage()));
                            },
                            child: Text('Login'),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(20),
                              shadowColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(11, 212, 134, 1),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
