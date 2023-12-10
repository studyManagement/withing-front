import 'package:flutter/cupertino.dart';

class StudyListHeader extends StatelessWidget {
  const StudyListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                '스터디',
                style: TextStyle(
                  color: Color(0xFF8B97A4),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 6),
              Text(
                '9,999',
                style: TextStyle(
                  color: Color(0xFF22262B),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          Text(
            '최신순',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF22262B),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
