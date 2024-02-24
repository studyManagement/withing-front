import 'package:flutter/material.dart';
import 'package:modi/common/components/exception/modi_exception.dart';

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
