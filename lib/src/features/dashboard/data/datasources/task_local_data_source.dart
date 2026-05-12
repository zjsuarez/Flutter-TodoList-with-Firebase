import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:todolistfirebase/src/features/dashboard/domain/entities/task.dart';
import 'package:todolistfirebase/src/features/dashboard/data/model/task_model.dart';

@lazySingleton
class TaskLocalDataSource {
  final Box<TaskModel> _taskBox;

  TaskLocalDataSource(this._taskBox);

  Future<void> saveTask(Task task) async {
    await _taskBox.put(task.id, TaskModel.fromDomain(task));
  }

  List<Task> getTasks() {
    return _taskBox.values.map((model) => model.toDomain()).toList();
  }

  Future<void> deleteTask(String id) async {
    await _taskBox.delete(id);
  }
}