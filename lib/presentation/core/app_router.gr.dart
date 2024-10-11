// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:attandence_system/presentation/add_member/add_member_view.dart'
    as _i1;
import 'package:attandence_system/presentation/dashboard/dashboard_view.dart'
    as _i2;
import 'package:attandence_system/presentation/face_recognization/face_detector_view.dart'
    as _i3;
import 'package:attandence_system/presentation/home/history/history_view.dart'
    as _i4;
import 'package:attandence_system/presentation/home/home_view.dart' as _i5;
import 'package:attandence_system/presentation/splash/splash_page.dart' as _i6;
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

/// generated route for
/// [_i1.AddMemberView]
class AddMemberView extends _i7.PageRouteInfo<AddMemberViewArgs> {
  AddMemberView({
    _i8.Key? key,
    bool isAdmin = false,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          AddMemberView.name,
          args: AddMemberViewArgs(
            key: key,
            isAdmin: isAdmin,
          ),
          initialChildren: children,
        );

  static const String name = 'AddMemberView';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddMemberViewArgs>(
          orElse: () => const AddMemberViewArgs());
      return _i1.AddMemberView(
        key: args.key,
        isAdmin: args.isAdmin,
      );
    },
  );
}

class AddMemberViewArgs {
  const AddMemberViewArgs({
    this.key,
    this.isAdmin = false,
  });

  final _i8.Key? key;

  final bool isAdmin;

  @override
  String toString() {
    return 'AddMemberViewArgs{key: $key, isAdmin: $isAdmin}';
  }
}

/// generated route for
/// [_i2.DashboardView]
class DashboardView extends _i7.PageRouteInfo<void> {
  const DashboardView({List<_i7.PageRouteInfo>? children})
      : super(
          DashboardView.name,
          initialChildren: children,
        );

  static const String name = 'DashboardView';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardView();
    },
  );
}

/// generated route for
/// [_i3.FaceDetectorView]
class FaceDetectorView extends _i7.PageRouteInfo<FaceDetectorViewArgs> {
  FaceDetectorView({
    _i8.Key? key,
    bool isUserRegistring = false,
    bool forDownloadData = false,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          FaceDetectorView.name,
          args: FaceDetectorViewArgs(
            key: key,
            isUserRegistring: isUserRegistring,
            forDownloadData: forDownloadData,
          ),
          initialChildren: children,
        );

  static const String name = 'FaceDetectorView';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FaceDetectorViewArgs>(
          orElse: () => const FaceDetectorViewArgs());
      return _i3.FaceDetectorView(
        key: args.key,
        isUserRegistring: args.isUserRegistring,
        forDownloadData: args.forDownloadData,
      );
    },
  );
}

class FaceDetectorViewArgs {
  const FaceDetectorViewArgs({
    this.key,
    this.isUserRegistring = false,
    this.forDownloadData = false,
  });

  final _i8.Key? key;

  final bool isUserRegistring;

  final bool forDownloadData;

  @override
  String toString() {
    return 'FaceDetectorViewArgs{key: $key, isUserRegistring: $isUserRegistring, forDownloadData: $forDownloadData}';
  }
}

/// generated route for
/// [_i4.HistoryView]
class HistoryView extends _i7.PageRouteInfo<void> {
  const HistoryView({List<_i7.PageRouteInfo>? children})
      : super(
          HistoryView.name,
          initialChildren: children,
        );

  static const String name = 'HistoryView';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.HistoryView();
    },
  );
}

/// generated route for
/// [_i5.HomeView]
class HomeView extends _i7.PageRouteInfo<void> {
  const HomeView({List<_i7.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeView();
    },
  );
}

/// generated route for
/// [_i6.SplashPage]
class SplashPage extends _i7.PageRouteInfo<void> {
  const SplashPage({List<_i7.PageRouteInfo>? children})
      : super(
          SplashPage.name,
          initialChildren: children,
        );

  static const String name = 'SplashPage';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashPage();
    },
  );
}
