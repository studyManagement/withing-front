import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 32,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFF4F7FC),
            ),
            child: const Row(
              children: [
                SizedBox(width: 16),
                Icon(
                  Icons.search,
                  color: Color(0xFFABB6C2),
                ),
                SizedBox(width: 8),
                Text(
                  '스터디 이름으로 검색해보세요.',
                  style: TextStyle(
                    color: Color(0xFFABB6C2),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
