import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? titleBottom;
  final double? titleFontSize;
  final double? scrolledUnderElevation;
  final Widget? bottomNavigationBar;
  final Widget? leader;
  final bool? centerTitle;
  final List<Widget>? actions;

  const DefaultLayout({
    this.backgroundColor,
    required this.child,
    this.title,
    this.titleBottom,
    this.titleFontSize,
    this.scrolledUnderElevation,
    this.bottomNavigationBar,
    this.leader,
    this.actions,
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
    );
  }

  AppBar? renderAppBar(BuildContext context) {
    if (title == null) {
      return null;
    }

    final bottomWidget = (titleBottom != null)
        ? PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: titleBottom!,
          )
        : null;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: centerTitle ?? true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          title!,
          style: TextStyle(
            color: AppColors.gray800,
            fontWeight: AppFonts.fontWeight600,
            fontSize: titleFontSize ?? 16,
          ),
        ),
      ),
      bottom: bottomWidget,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: leader,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: actions ?? [],
          ),
        ),
      ],
      scrolledUnderElevation: scrolledUnderElevation ?? 0,
    );
  }
}
