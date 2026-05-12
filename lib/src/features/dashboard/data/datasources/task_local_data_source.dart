import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:todolistfirebase/src/features/dashboard/domain/entities/task.dart';

@lazySingleton
class TaskLocalDataSource {
  final Box<Task> _TaskBox;

  TaskLocalDataSource(this._TaskBox);

  Future<void> saveTask(Task task) async {
    await _TaskBox.add(task);
  }

  List<Task> getTasks() {
    return _TaskBox.values.toList();
  }

  Future<void> deleteTask(String id) async {
    await _TaskBox.delete(id);
  }
}