import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

// NoAnimation 사용하려면 플러터 버전 업그레이드 해야 됨
// https://github.com/flutter/flutter/issues/145585
class _NoScalingAnimation extends FloatingActionButtonAnimator {
  @override
  Offset getOffset(
      {required Offset begin, required Offset end, required double progress}) {
    return end;
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }
}

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Color? appBarShadowColor;
  final Widget child;
  final String? title;
  final Widget? customTitleWidget;
  final Widget? titleBottom;
  final double? titleFontSize;
  final double? scrolledUnderElevation;
  final double? elevation;
  final Widget? bottomNavigationBar;
  final Widget? leader;
  final bool? resizeToAvoidBottomInset;
  final bool? centerTitle;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const DefaultLayout({
    this.backgroundColor,
    this.appBarShadowColor,
    required this.child,
    this.title,
    this.customTitleWidget,
    this.titleBottom,
    this.titleFontSize,
    this.scrolledUnderElevation,
    this.elevation,
    this.bottomNavigationBar,
    this.leader,
    this.actions,
    this.resizeToAvoidBottomInset,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.centerTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(context),
      body: SafeArea(child: child),
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
      floatingActionButtonAnimator: _NoScalingAnimation(),
    );
  }

  AppBar? renderAppBar(BuildContext context) {
    if (title == null && customTitleWidget == null) {
      return null;
    }

    assert(!(title != null && customTitleWidget != null),
        "title하고 customTitleWidget은 동시에 선언할 수 없습니다.");

    final bottomWidget = (titleBottom != null)
        ? PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: titleBottom!,
          )
        : null;

    final titleLeader = (leader != null)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: leader,
          )
        : null;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: elevation ?? 0,
      surfaceTintColor: Colors.white,
      shadowColor: appBarShadowColor ?? Colors.transparent,
      centerTitle: centerTitle ?? true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: (title != null)
            ? Text(
                title!,
                style: TextStyle(
                  color: AppColors.gray800,
                  fontWeight: AppFonts.fontWeight600,
                  fontSize: titleFontSize ?? 16,
                ),
              )
            : customTitleWidget,
      ),
      bottom: bottomWidget,
      leading: titleLeader,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: actions ?? [],
          ),
        ),
      ],
      scrolledUnderElevation: scrolledUnderElevation ?? 0,
    );
  }
}
