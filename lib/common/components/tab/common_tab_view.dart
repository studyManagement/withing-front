import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class CommonTabView extends StatefulWidget {
  final List<String> tabTitles;
  final List<Widget> tabViews;
  final int initialIndex;
  final TabBarIndicatorSize indicatorSize;

  const CommonTabView({
    super.key,
    required this.tabTitles,
    required this.tabViews,
    this.initialIndex = 0,
    this.indicatorSize = TabBarIndicatorSize.tab
  });

  @override
  State<CommonTabView> createState() => _CommonTabViewState();
}

class _CommonTabViewState extends State<CommonTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabTitles.length,
      vsync: this,
      initialIndex: widget.initialIndex,
      animationDuration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          dividerColor: AppColors.gray150,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.0, color: AppColors.blue600),
          ),
          indicatorSize: widget.indicatorSize,
          indicatorWeight: 2,
          labelStyle: const TextStyle(
            color: AppColors.gray800,
            fontWeight: AppFonts.fontWeight600,
            fontSize: 16,
          ),
          unselectedLabelStyle: const TextStyle(
            color: AppColors.gray300,
            fontWeight: AppFonts.fontWeight600,
            fontSize: 16,
          ),
          tabs: widget.tabTitles.map((title) => Tab(text: title)).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabViews,
          ),
        ),
      ],
    );
  }
}