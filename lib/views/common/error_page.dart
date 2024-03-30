import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/button/circle_button.dart';
import 'package:modi/common/components/exception/modi_exception.dart';
import 'package:modi/common/layout/default_layout.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      leader: CircleButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        onTap: () {
          if (context.canPop()) {
            context.pop();
            return;
          }

          context.go('/');
        },
      ),
      title: '',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ModiException(const [
              '현재 버전에서는 컨텐츠를 이용할 수 없어요.',
              '앱스토어에서 업데이트 후 다시 이용해 주시기 바랍니다.'
            ]),
          ),
        ],
      ),
    );
  }
}
