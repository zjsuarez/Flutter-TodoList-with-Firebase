import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/task.dart';
import '../../../../domain/usecases/add_task_usecase.dart';
import '../../../../domain/usecases/delete_task_usecase.dart';
import '../../../../domain/usecases/get_tasks_usecase.dart';
import '../../../../domain/usecases/update_task_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';
part 'dashboard_bloc.freezed.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetTasksUseCase _getTasksUseCase;
  final AddTaskUseCase _addTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  DashboardBloc(
    this._getTasksUseCase,
    this._addTaskUseCase,
    this._updateTaskUseCase,
    this._deleteTaskUseCase,
  ) : super(const DashboardState.initial()) {
    on<_Started>((event, emit) {
      add(const DashboardEvent.getTasks());
    });
    
    on<_GetTasks>(_onGetTasks);
    on<_AddTask>(_onAddTask);
    on<_UpdateTask>(_onUpdateTask);
    on<_DeleteTask>(_onDeleteTask);
  }

  Future<void> _onGetTasks(_GetTasks event, Emitter<DashboardState> emit) async {
    emit(const DashboardState.loading());
    try {
      final tasks = await _getTasksUseCase();
      emit(DashboardState.loaded(tasks));
    } catch (e) {
      emit(DashboardState.error(e.toString()));
    }
  }

  Future<void> _onAddTask(_AddTask event, Emitter<DashboardState> emit) async {
    try {
      await _addTaskUseCase(event.task);
      add(const DashboardEvent.getTasks());
    } catch (e) {
      emit(DashboardState.error(e.toString()));
    }
  }

  Future<void> _onUpdateTask(_UpdateTask event, Emitter<DashboardState> emit) async {
    try {
      await _updateTaskUseCase(event.task);
      add(const DashboardEvent.getTasks());
    } catch (e) {
      emit(DashboardState.error(e.toString()));
    }
  }

  Future<void> _onDeleteTask(_DeleteTask event, Emitter<DashboardState> emit) async {
    try {
      await _deleteTaskUseCase(event.id);
      add(const DashboardEvent.getTasks());
    } catch (e) {
      emit(DashboardState.error(e.toString()));
    }
  }
}
