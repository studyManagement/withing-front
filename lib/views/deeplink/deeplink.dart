import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class Deeplink extends StatelessWidget {
  const Deeplink({this.path, super.key});

  final String? path;

  void _pushRoute(BuildContext context, String? path) async {
    if (path != null) {
      context.push('/my/profle');
    }

    await Future.delayed(const Duration(microseconds: 50));
  }

  @override
  Widget build(BuildContext context) {
    _pushRoute(context, path);

    return Container();
  }
}
