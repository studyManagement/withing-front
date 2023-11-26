import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryItem(title: '전체', isSelected: true),
              CategoryItem(title: '어학'),
              CategoryItem(title: '자격증'),
              CategoryItem(title: '취업'),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryItem(title: '시험'),
              CategoryItem(title: '취미'),
              CategoryItem(title: '프로그래밍'),
              CategoryItem(title: '기타'),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CategoryItem({
    super.key,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isSelected ? const Color(0xFF1F3258) : Colors.transparent,
              ),
              color: const Color(0xFFE0E8F0),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(title),
      ],
    );
  }
}
