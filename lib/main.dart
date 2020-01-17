import 'package:clock_app/screens/clockTab.dart';
import 'package:clock_app/screens/recordsTab.dart';
import 'package:clock_app/screens/settingsTab.dart';
import 'package:flutter/material.dart';

enum _Element {
  background,
  text,
  shadow,
}

final _lightTheme = {
  _Element.background: Color(0xFF81B3FE),
  _Element.text: Colors.white,
  _Element.shadow: Colors.black,
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
  _Element.shadow: Color(0xFF174EA6),
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppClock(),
    );
  }
}

class AppClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    final fontSize = MediaQuery.of(context).size.width / 3.5;
    final defaultStyle = TextStyle(
      color: colors[_Element.text],
      fontFamily: 'PressStart2P',
      fontSize: fontSize,
      shadows: [
        Shadow(
          blurRadius: 0,
          color: colors[_Element.shadow],
          offset: Offset(10, 0),
        ),
      ],
    );
    return Container(
        color: colors[_Element.background],
        height: 600,
        width: double.infinity,
        child: DefaultTextStyle(
          style: defaultStyle,
          child: DefaultTabController(
              length: 3,
              child: Scaffold(
                  bottomNavigationBar: BottomBar(),
                  appBar: AppBar(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(55),
                      child: Container(
                        color: Colors.transparent,
                        child: SafeArea(
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                  indicator: UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                          color: Color(0xffff0863), width: 4.0),
                                      insets: EdgeInsets.fromLTRB(
                                          40.0, 20.0, 40.0, 0)),
                                  indicatorWeight: 15,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  labelColor: Color(0xff2d386b),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      letterSpacing: 1.3,
                                      fontWeight: FontWeight.w500),
                                  unselectedLabelColor: Colors.black26,
                                  tabs: [
                                    Tab(
                                      text: "CLOCK",
                                      icon: Icon(Icons.access_time, size: 30),
                                    ),
                                    Tab(
                                      text: "RECORDS",
                                      icon: Icon(Icons.history, size: 30),
                                    ),
                                    Tab(
                                      text: "SETTINGS",
                                      icon: Icon(Icons.settings, size: 30),
                                    ),
                                  ])
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      Center(
                        child: ClockTab(),
                      ),
                      Center(
                        child: RecordsTab(),
                      ),
                      Center(
                        child: SettingsTab(),
                      )
                    ],
                  ))),
        ));
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 0, 50, 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton(
            elevation: 7,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.add_alarm,
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "SET ALARMS",
                  style: TextStyle(letterSpacing: 0.5, fontSize: 12),
                ),
              ],
            ),
            color: Color(0xffff5e92),
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {},
          ),
          FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            elevation: 5,
            highlightElevation: 3,
            icon: Icon(
              Icons.timer,
              size: 15,
            ),
            label: Text(
              'Stop watch',
              style: TextStyle(letterSpacing: 0.5, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
