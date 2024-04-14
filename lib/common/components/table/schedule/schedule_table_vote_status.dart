import 'package:flutter/material.dart';

class ScheduleTableVoteStatus {
  String nickname;
  String? profileImage;
  TimeOfDay selectedTime;

  ScheduleTableVoteStatus(
    this.nickname,
    this.profileImage,
    this.selectedTime,
  );
}
