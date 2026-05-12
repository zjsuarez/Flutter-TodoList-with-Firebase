// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;
import 'package:todolistfirebase/src/core/di/injection.dart' as _i257;
import 'package:todolistfirebase/src/features/dashboard/data/datasources/task_local_data_source.dart'
    as _i571;
import 'package:todolistfirebase/src/features/dashboard/data/repositories/task_repository_impl.dart'
    as _i329;
import 'package:todolistfirebase/src/features/dashboard/domain/entities/task.dart'
    as _i39;
import 'package:todolistfirebase/src/features/dashboard/domain/repositories/task_repository.dart'
    as _i812;
import 'package:todolistfirebase/src/features/dashboard/domain/usecases/add_task_usecase.dart'
    as _i68;
import 'package:todolistfirebase/src/features/dashboard/domain/usecases/delete_task_usecase.dart'
    as _i677;
import 'package:todolistfirebase/src/features/dashboard/domain/usecases/get_tasks_usecase.dart'
    as _i643;
import 'package:todolistfirebase/src/features/dashboard/domain/usecases/update_task_usecase.dart'
    as _i692;
import 'package:todolistfirebase/src/features/dashboard/presentation/bloc/dashboard/bloc/dashboard_bloc.dart'
    as _i365;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i979.Box<_i39.Task>>(() => registerModule.taskBox);
    gh.lazySingleton<_i571.TaskLocalDataSource>(
        () => _i571.TaskLocalDataSource(gh<_i979.Box<_i39.Task>>()));
    gh.lazySingleton<_i812.TaskRepository>(
        () => _i329.TaskRepositoryImpl(gh<_i571.TaskLocalDataSource>()));
    gh.lazySingleton<_i68.AddTaskUseCase>(
        () => _i68.AddTaskUseCase(gh<_i812.TaskRepository>()));
    gh.lazySingleton<_i677.DeleteTaskUseCase>(
        () => _i677.DeleteTaskUseCase(gh<_i812.TaskRepository>()));
    gh.lazySingleton<_i643.GetTasksUseCase>(
        () => _i643.GetTasksUseCase(gh<_i812.TaskRepository>()));
    gh.lazySingleton<_i692.UpdateTaskUseCase>(
        () => _i692.UpdateTaskUseCase(gh<_i812.TaskRepository>()));
    gh.factory<_i365.DashboardBloc>(() => _i365.DashboardBloc(
          gh<_i643.GetTasksUseCase>(),
          gh<_i68.AddTaskUseCase>(),
          gh<_i692.UpdateTaskUseCase>(),
          gh<_i677.DeleteTaskUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i257.RegisterModule {}
