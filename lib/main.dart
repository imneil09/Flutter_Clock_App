import 'package:bloc/bloc.dart';
import 'package:clock_app/Timer/data/database.dart';
import 'package:clock_app/Timer/data/task_manager.dart';
import 'package:clock_app/Timer/pages/home_page/home_bloc.dart';
import 'package:clock_app/Timer/pages/home_page/home_page.dart';
import 'package:clock_app/Timer/pages/new_task_page.dart';
import 'package:clock_app/screens/clockTab.dart';
import 'package:clock_app/screens/recordsTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

void main() {
  BlocSupervisor().delegate = MyDelegate();
  DatabaseProvider dbProvider = DatabaseProvider.db;
  TaskManager taskManager = TaskManager(dbProvider: dbProvider);
  HomeBloc homeBloc = HomeBloc(taskManager: taskManager);
  runApp(MyApp(
    homeBloc: homeBloc,
  ));
}

class MyApp extends StatefulWidget {
  final HomeBloc homeBloc;

  const MyApp({Key key, this.homeBloc}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    widget.homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClockApp(
        homeBloc: widget.homeBloc,
      ),
      routes: <String, WidgetBuilder>{
        '/new': (BuildContext context) => NewTaskPage(),
      },
    );
  }
}

class ClockApp extends StatefulWidget {
  final HomeBloc homeBloc;

  const ClockApp({Key key, this.homeBloc}) : super(key: key);

  @override
  _ClockAppState createState() => _ClockAppState();
}

class _ClockAppState extends State<ClockApp> {
  @override
  void dispose() {
    widget.homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
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
                                insets:
                                    EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0)),
                            indicatorWeight: 15,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelColor: Color(0xff2d386b),
                            labelStyle: TextStyle(
                                fontSize: 12,
                                letterSpacing: 1.3,
                                fontWeight: FontWeight.w500),
                            unselectedLabelColor: Color(0xffff5e92),
                            tabs: [
                              Tab(
                                text: "CLOCK",
                                icon: Icon(Icons.access_time, size: 30),
                              ),
                              Tab(
                                text: "TASK TIMER",
                                icon: Icon(
                                  Icons.hourglass_empty,
                                  size: 30,
                                ),
                              ),
                              Tab(
                                text: "RECORDS",
                                icon: Icon(Icons.history, size: 30),
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
                BlocProvider<HomeBloc>(
                    bloc: widget.homeBloc,
                    child: Center(
                      child: HomePage(
                        homeBloc: widget.homeBloc,
                      ),
                    )),
                Center(
                  child: RecordsTab(),
                )
              ],
            ),
          )),
    );
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
