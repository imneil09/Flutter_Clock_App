import 'dart:async';

import 'package:clock_app/Timer/data/database.dart';
import 'package:clock_app/Timer/model/task_model.dart';


class TaskManager {

  final DatabaseProvider dbProvider;

  TaskManager({ this.dbProvider});

  Future<void> addNewTask(Task task) async {
    return dbProvider.insert(task);
  }

  Future<List<Task>> loadAllTasks() async {
    return dbProvider.getAll();
  }

  Future<void> deleteTask(Task task) async {
    return dbProvider.delete(task.id);
  }
}
