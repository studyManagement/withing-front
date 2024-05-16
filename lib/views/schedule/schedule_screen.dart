import 'package:flutter/material.dart';
import 'package:modi/common/components/bottom_shadow.dart';
import 'package:modi/common/components/schedule/schedule_list.dart';
import 'package:modi/common/components/schedule/schedule_list_item.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/model/schedule/schedule_group_model.dart';
import 'package:modi/model/schedule/schedule_model.dart';
import 'package:modi/view_models/schedule/user/user_schedule_viewmodel.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<UserScheduleViewModel>();
    viewModel.scrollListener(context);
    return DefaultLayout(
      title: viewModel.titleDateString,
      centerTitle: false,
      titleFontSize: 20,
      elevation: 10,
      appBarShadowColor: Color.fromARGB(40, 0, 0, 0),
      child: ScheduleList(),
    );
  }
}
