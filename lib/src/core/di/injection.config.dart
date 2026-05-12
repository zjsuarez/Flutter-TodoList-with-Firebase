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
import 'package:todolistfirebase/src/features/dashboard/domain/entities/task.dart'
    as _i39;

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
    return this;
  }
}

class _$RegisterModule extends _i257.RegisterModule {}
