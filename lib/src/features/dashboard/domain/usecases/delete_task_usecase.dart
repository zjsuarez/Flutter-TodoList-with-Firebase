import 'package:injectable/injectable.dart';
import 'package:todolistfirebase/src/features/dashboard/domain/repositories/task_repository.dart';

@lazySingleton
class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteTask(id);
  }
}
