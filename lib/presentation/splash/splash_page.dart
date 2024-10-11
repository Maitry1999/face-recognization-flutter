import 'dart:developer';

import 'package:attandence_system/presentation/core/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:attandence_system/application/auth/auth_status/auth_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'splashPage')
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthStatusBloc, AuthStatusState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          authenticated: (Authenticated value) async {
            log('authenticated');
            await Future.delayed(
              Duration(seconds: 1),
              () {
                context.router.replace(PageRouteInfo(DashboardView.name));
              },
            );
          },
          unauthenticated: (Unauthenticated value) async {
            log('unauthenticated');
            await Future.delayed(
              Duration(seconds: 1),
              () {
                context.router.replace(PageRouteInfo(DashboardView.name));
              },
            );
          },
        );
      },
      child: const Scaffold(
        body: Center(
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
