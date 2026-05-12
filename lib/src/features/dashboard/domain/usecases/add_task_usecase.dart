import 'package:injectable/injectable.dart';
import 'package:todolistfirebase/src/features/dashboard/domain/entities/task.dart';
import 'package:todolistfirebase/src/features/dashboard/domain/repositories/task_repository.dart';

@lazySingleton
class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future<void> call(Task task) async {
    return await repository.addTask(task);
  }
}
