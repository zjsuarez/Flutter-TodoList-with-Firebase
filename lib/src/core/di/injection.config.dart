// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;
import 'package:todolistfirebase/src/core/di/injection.dart' as _i257;
import 'package:todolistfirebase/src/features/auth/data/datasources/auth_datasource.dart'
    as _i688;
import 'package:todolistfirebase/src/features/auth/data/repositories/auth_repository_impl.dart'
    as _i545;
import 'package:todolistfirebase/src/features/auth/domain/repositories/auth_repository.dart'
    as _i961;
import 'package:todolistfirebase/src/features/auth/domain/usecases/register_usecase.dart'
    as _i978;
import 'package:todolistfirebase/src/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i876;
import 'package:todolistfirebase/src/features/auth/domain/usecases/sign_out_usecase.dart'
    as _i797;
import 'package:todolistfirebase/src/features/auth/presentation/bloc/auth_bloc.dart'
    as _i817;
import 'package:todolistfirebase/src/features/dashboard/data/datasources/task_local_data_source.dart'
    as _i571;
import 'package:todolistfirebase/src/features/dashboard/data/model/task_model.dart'
    as _i899;
import 'package:todolistfirebase/src/features/dashboard/data/repositories/task_repository_impl.dart'
    as _i329;
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
    gh.lazySingleton<_i979.Box<_i899.TaskModel>>(() => registerModule.taskBox);
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i571.TaskLocalDataSource>(
        () => _i571.TaskLocalDataSource(gh<_i979.Box<_i899.TaskModel>>()));
    gh.lazySingleton<_i961.AuthRepository>(
        () => _i545.AuthRepositoryImpl(gh<InvalidType>()));
    gh.lazySingleton<_i688.AuthDataSource>(
        () => _i688.AuthDataSource(gh<_i59.FirebaseAuth>()));
    gh.lazySingleton<_i812.TaskRepository>(
        () => _i329.TaskRepositoryImpl(gh<_i571.TaskLocalDataSource>()));
    gh.factory<_i978.RegisterUseCase>(
        () => _i978.RegisterUseCase(gh<_i961.AuthRepository>()));
    gh.factory<_i876.SignInUseCase>(
        () => _i876.SignInUseCase(gh<_i961.AuthRepository>()));
    gh.factory<_i797.SignOutUseCase>(
        () => _i797.SignOutUseCase(gh<_i961.AuthRepository>()));
    gh.factory<_i817.AuthBloc>(() => _i817.AuthBloc(
          gh<_i876.SignInUseCase>(),
          gh<_i978.RegisterUseCase>(),
          gh<_i797.SignOutUseCase>(),
        ));
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
