import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/theme/app/app_colors.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
      //     onPressed: () {
      //       context.pop(context);
      //     },
      //   ),
      //   backgroundColor: Colors.transparent,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('asset/exclamation.png', width: 40, height: 40),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              '현재 버전에서는 해당 컨텐츠를 이용할 수 없어요.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          const Center(
            child: Text(
              '앱스토어에서 버전 업데이트 후 다시 이용해 주시기 바랍니다.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/home');
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: AppColors.blue600,
            ),
            child: const Text(
              '홈으로',
              style: TextStyle(color: AppColors.white),
            ),
          )
        ],
      ),
    );
  }
}
