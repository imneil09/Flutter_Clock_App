import 'package:clock_app/Timer/model/task_model.dart';
import 'package:clock_app/Timer/pages/bottom_sheet.dart';
import 'package:clock_app/Timer/pages/home_page/home_bloc.dart';
import 'package:clock_app/Timer/pages/home_page/home_events.dart';
import 'package:clock_app/Timer/pages/home_page/home_state.dart';
import 'package:clock_app/Timer/pages/new_task_page.dart';
import 'package:clock_app/Timer/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  final HomeBloc homeBloc;

  const HomePage({@required this.homeBloc}) : assert(homeBloc != null);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc get _homeBloc => widget.homeBloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openBottomSheet() async {
    final newTask = await showCustomModalBottomSheet<Task>(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              color: Color(0xFF737373),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: NewTaskPage(),
              ),
            ),
          );
        });

    if (newTask != null) {
      _homeBloc.dispatch(SaveTaskEvent(task: newTask));
    }
  }

  @override
  void initState() {
    _homeBloc.dispatch(LoadTasksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add_circle, size: 42, color: Color(0xffff5e92)),
        backgroundColor: Colors.white,
        onPressed: _openBottomSheet,
      ),
      body: Container(
        child: BlocBuilder<HomeEvent, HomeState>(
            bloc: _homeBloc,
            builder: (BuildContext context, state) {
              if (state is HomeStateLoading)
                return Center(child: CircularProgressIndicator());

              if (state is HomeStateLoaded) {
                final List<Task> tasks = state.tasks;

                if (tasks.isEmpty)
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('NO TASKS ARE AVAILABLE !',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Add a new Task now and it will show up here.',
                            textAlign: TextAlign.center)
                      ],
                    ),
                  );

                return ListView.builder(
                  itemCount: tasks.length,
                  padding: const EdgeInsets.only(top: 8),
                  itemBuilder: (BuildContext context, int index) {
                    final Task item = tasks.elementAt(index);
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Dismissible(
                        background: Container(color: Colors.red),
                        direction: DismissDirection.endToStart,
                        key: ObjectKey(item),
                          child: TaskWidget(task: item),
                        onDismissed: (direction) {
                          tasks.remove(item);
                          setState(() {});
                          _homeBloc.dispatch(DeleteTaskEvent(task: item));

                          Scaffold.of(context)
                              .showSnackBar(
                              SnackBar(content: Text("Task Deleted")));
                        },
                      ),
                    );
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            }),
      ),
    );
  }
}
