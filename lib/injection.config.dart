// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:attandence_system/application/add_new_member/add_new_member_bloc.dart'
    as _i754;
import 'package:attandence_system/application/auth/auth_status/auth_status_bloc.dart'
    as _i1020;
import 'package:attandence_system/application/dashboard/dashboard_bloc.dart'
    as _i654;
import 'package:attandence_system/application/home/home_bloc.dart' as _i334;
import 'package:attandence_system/domain/auth/i_auth_facade.dart' as _i947;
import 'package:attandence_system/infrastructure/auth/auth_facade.dart' as _i9;
import 'package:attandence_system/infrastructure/core/network/injectable_module.dart'
    as _i756;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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
    gh.factory<_i334.HomeBloc>(() => _i334.HomeBloc());
    gh.factory<_i654.DashboardBloc>(() => _i654.DashboardBloc());
    gh.lazySingleton<_i756.ApiService>(() => _i756.ApiService());
    gh.lazySingleton<_i947.IAuthFacade>(
        () => _i9.AuthFacade(gh<_i756.ApiService>()));
    gh.factory<_i754.AddNewMemberBloc>(
        () => _i754.AddNewMemberBloc(gh<_i947.IAuthFacade>()));
    gh.factory<_i1020.AuthStatusBloc>(
        () => _i1020.AuthStatusBloc(gh<_i947.IAuthFacade>()));
    return this;
  }
}
