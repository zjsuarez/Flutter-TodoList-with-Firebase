import 'package:todolistfirebase/src/features/dashboard/data/datasources/task_local_data_source.dart';
import 'package:todolistfirebase/src/features/dashboard/domain/entities/task.dart';
import 'package:todolistfirebase/src/features/dashboard/domain/repositories/task_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository{

  final TaskLocalDataSource taskLocalDataSource;

  TaskRepositoryImpl(this.taskLocalDataSource);

  @override
  Future<void> addTask(Task task) async {
    await taskLocalDataSource.saveTask(task);
  }

  @override
  Future<void> deleteTask(String id) async {
    await taskLocalDataSource.deleteTask(id);
  }

  @override
  Future<List<Task>> getTasks() async {
    return taskLocalDataSource.getTasks();
  }

  @override
  Future<void> updateTask(Task task) async {
    await taskLocalDataSource.saveTask(task);
  }
}