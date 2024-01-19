import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateStudyButton extends StatelessWidget {
  const CreateStudyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.push('/studies/new');
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      ),
      child: Icon(
        Icons.add,
        size: 32.0,
        color: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
