import 'package:auto_route/auto_route.dart';
import 'package:attandence_system/presentation/core/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashPage.page, initial: true),
        AutoRoute(page: AddMemberView.page),
        AutoRoute(page: FaceDetectorView.page),
        AutoRoute(page: DashboardView.page),
        AutoRoute(page: SuccessScreen.page),
        AutoRoute(page: FaceVerificationTaskScreen.page),
      ];
}
