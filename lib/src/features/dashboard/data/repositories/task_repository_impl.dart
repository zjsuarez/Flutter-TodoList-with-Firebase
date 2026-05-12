import 'package:todolistfirebase/src/features/dashboard/data/datasources/task_local_data_source.dart';
import 'package:todolistfirebase/src/features/dashboard/domain/entities/task.dart';
import 'package:todolistfirebase/src/features/dashboard/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository{

  final TaskLocalDataSource taskLocalDataSource;

  TaskRepositoryImpl(this.taskLocalDataSource);

  @override
  Future<void> addTask(Task task) {
    taskLocalDataSource.saveTask(task);
    return Future.value();
  }

  @override
  Future<void> deleteTask(String id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTasks() {
    // TODO: implement getTasks
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}