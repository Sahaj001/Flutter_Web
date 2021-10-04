import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:typing_class/login.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:typing_class/typingPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<SpeedData> _userSpeedGrowth;

  List<SpeedData> _userSpeed;
  @override
  void initState() {
    super.initState();
    _userSpeedGrowth = getSpeedGrowth();
    _userSpeed = getSpeedData();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

    return new Scaffold(
      key: _scaffoldState,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return Stack(
              children: [
                _bgContainer(),
                _wideContainer(),
                _homeButton(_scaffoldState),
              ],
            );
          } else {
            return Stack(
              children: [
                _bgContainer(),
                _narrowContainer(),
                _homeButton(_scaffoldState),
              ],
            );
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.dashboard,
                  color: Colors.blue,
                  size: 36.0,
                ),
              ),
            ),
            Container(
              width: 12,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Profile!'),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 12,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: const Text('Log Out!'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeButton(_scaffoldState) {
    return Positioned(
      child: IconButton(
        padding: EdgeInsets.all(20),
        iconSize: 35,
        color: Colors.blue,
        icon: Icon(Icons.menu_rounded),
        onPressed: () => _scaffoldState.currentState.openDrawer(),
      ),
    );
  }

  Widget _bgContainer() {
    return Container(
      child: SvgPicture.asset(
        'assets/images/bg_fig_1.svg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _wideContainer() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: new Center(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                      height: 600,
                      width: MediaQuery.of(context).size.width * 0.70,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 100),
                          Container(
                            width: 180,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.blue[200], width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Typing Level',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.blue),
                            ),
                          ),
                          _selectButton('Easy'),
                          _selectButton('Medium'),
                          _selectButton('Hard'),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Center(
                      child: Card(
                        elevation: 30,
                        color: Colors.orangeAccent,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Icon(
                                Icons.flag,
                                color: Colors.redAccent[400],
                                size: 70.0,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: Text(
                                  'Typing Speed : 50wpm',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: Text(
                                  'Rank : 2000/2800',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Check Your Improvement',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.amber,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.cyan[50],
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(text: 'Improvement in Speed'),
                        series: <LineSeries<SpeedData, String>>[
                          LineSeries<SpeedData, String>(
                              dataSource: _userSpeedGrowth,
                              xValueMapper: (SpeedData user, _) => user.x,
                              yValueMapper: (SpeedData user, _) => user.y,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true)),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.cyan[50],
                      child: SfCircularChart(
                        title: ChartTitle(text: 'Speeds!'),
                        series: <CircularSeries>[
                          PieSeries<SpeedData, String>(
                            dataSource: _userSpeed,
                            xValueMapper: (SpeedData user, _) => user.x,
                            yValueMapper: (SpeedData user, _) => user.y,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectButton(text) {
    return SizedBox(
      width: 240,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TypePage()));
        },
        child: Text(text),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(20),
          shadowColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromRGBO(11, 212, 134, 1),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _narrowContainer() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: new Center(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                      height: 600,
                      width: MediaQuery.of(context).size.width * 0.70,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 100),
                          Container(
                            width: 180,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.blue[200], width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Typing Level',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.blue),
                            ),
                          ),
                          _selectButton('Easy'),
                          _selectButton('Medium'),
                          _selectButton('Hard'),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Center(
                      child: Card(
                        elevation: 30,
                        color: Colors.orangeAccent,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Icon(
                                Icons.flag,
                                color: Colors.redAccent[400],
                                size: 70.0,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: Text(
                                  'Typing Speed : 50wpm',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: Text(
                                  'Rank : 2000/2800',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Check Your Improvement',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.amber,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.cyan[50],
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(text: 'Improvement in Speed'),
                        series: <LineSeries<SpeedData, String>>[
                          LineSeries<SpeedData, String>(
                              dataSource: _userSpeedGrowth,
                              xValueMapper: (SpeedData user, _) => user.x,
                              yValueMapper: (SpeedData user, _) => user.y,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true)),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.cyan[50],
                      child: SfCircularChart(
                        title: ChartTitle(text: 'Speeds!'),
                        series: <CircularSeries>[
                          PieSeries<SpeedData, String>(
                            dataSource: _userSpeed,
                            xValueMapper: (SpeedData user, _) => user.x,
                            yValueMapper: (SpeedData user, _) => user.y,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<SpeedData> getSpeedGrowth() {
    final List<SpeedData> userSpeedGrowth = [
      SpeedData('August', 60),
      SpeedData('September', 64),
      SpeedData('October', 74),
    ];
    return userSpeedGrowth;
  }

  List<SpeedData> getSpeedData() {
    final List<SpeedData> userSpeed = [
      SpeedData('Easy', 70),
      SpeedData('Medium', 60),
      SpeedData('Hard', 40),
    ];
    return userSpeed;
  }
}

class SpeedData {
  SpeedData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
