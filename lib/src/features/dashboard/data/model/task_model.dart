import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/task.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  const TaskModel._(); 

  @HiveType(typeId: 0, adapterName: 'TaskAdapter')
  const factory TaskModel({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String description,
    @HiveField(3) required bool isCompleted,
    @HiveField(4) required DateTime date,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

  // ---MAPPERS---

  Task toDomain() {
    return Task(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      date: date,
    );
  }
  
  factory TaskModel.fromDomain(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      date: task.date,
    );
  }
}