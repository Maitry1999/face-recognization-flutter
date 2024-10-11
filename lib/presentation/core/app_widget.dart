import 'package:attandence_system/application/auth/auth_status/auth_status_bloc.dart';
import 'package:attandence_system/injection.dart';
import 'package:attandence_system/presentation/core/app_router.dart';
import 'package:attandence_system/presentation/core/app_theme.dart';
import 'package:attandence_system/presentation/core/widgets/utility/life_cycle_watcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return bloc.MultiBlocProvider(
      providers: [
        bloc.BlocProvider(
          create: (context) => getIt<AuthStatusBloc>()
            ..add(
              const AuthStatusEvent.authCheckRequested(),
            ),
        ),
      ],
      child: _App(),
    );
  }
}

class _App extends StatefulWidget {
  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  final appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return LifecycleWatcher(
      child: ScreenUtilInit(
        ensureScreenSize: true,
        child: MaterialApp.router(
          title: 'Attandence System',
          debugShowCheckedModeBanner: false,
          theme: ThemeConfig.lightTheme,
          routerConfig: appRouter.config(),
          localeResolutionCallback: (locale, supportedLocales) {
            for (final supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }

            return supportedLocales.first;
          },
        ),
      ),
    );
  }
}
