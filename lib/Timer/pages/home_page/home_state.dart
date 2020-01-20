import 'package:clock_app/Timer/model/task_model.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

class HomeState extends Equatable{
  HomeState([List tmp = const []]): super(tmp);
}

class HomeStateLoading extends HomeState{
  @override
  String toString() => 'HomeStateLoading';
}

class HomeStateLoaded extends HomeState{
  final List<Task> tasks;
  HomeStateLoaded({ @required this.tasks}): super(tasks);

  @override
  String toString() => 'HomeStateLoaded';
}