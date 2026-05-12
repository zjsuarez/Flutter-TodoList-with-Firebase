part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.started() = _Started;
  const factory DashboardEvent.getTasks() = _GetTasks;
  const factory DashboardEvent.addTask(Task task) = _AddTask;
  const factory DashboardEvent.deleteTask(String id) = _DeleteTask;
  const factory DashboardEvent.updateTask(Task task) = _UpdateTask;
}