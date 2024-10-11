import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/presentation/common/widgets/base_text.dart';
import 'package:attandence_system/presentation/core/style/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class PaginatedListView extends StatelessWidget {
  final Widget child;
  final bool isNoDataFound;
  final bool? enablePullUp;
  final bool? enablePullDown;
  final String? dataStatus;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final RefreshController refreshController;
  final bool reverse;
  final Axis? scrollDirection;
  const PaginatedListView({
    super.key,
    required this.onRefresh,
    required this.onLoading,
    required this.child,
    required this.refreshController,
    this.isNoDataFound = false,
    this.dataStatus,
    this.reverse = false,
    this.scrollDirection,
    this.enablePullUp,
    this.enablePullDown,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      header: MaterialClassicHeader(
        color: AppColors.black,
      ),
      enablePullUp: true,
      enablePullDown: true,
      reverse: reverse,
      scrollDirection: scrollDirection,
      controller: refreshController,
      physics: BouncingScrollPhysics(),
      onRefresh: () {
        onRefreshData();
      },
      onLoading: () {
        onLoadMoreData();
      },
      child: isNoDataFound
          ? Center(
              child: SizedBox(
                width: getSize(280),
                child: BaseText(
                  textColor: AppColors.black.withOpacity(0.65),
                  text: dataStatus ?? 'No result found.',
                  textAlign: TextAlign.center,
                  lineHeight: 1.2,
                ),
              ),
            )
          : child,
    );
  }

  onRefreshData() {
    onRefresh();
    refreshController.refreshCompleted();
  }

  onLoadMoreData() {
    onLoading();
    refreshController.loadComplete();
  }
}
