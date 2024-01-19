import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
    required TextEditingController controller,
    required FocusNode focusNode,
  })  : _controller = controller,
        _focusNode = focusNode;

  final TextEditingController _controller;
  final FocusNode _focusNode;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leadingWidth: 60.0,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: SizedBox(
          height: 36.0,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: true,
            onSubmitted: (String value) {
              debugPrint('입력값: $value');
            },
            cursorHeight: 20,
            maxLength: 20,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              counterText: "",
              hintText: '스터디 이름을 검색해보세요.',
              hintStyle: Theme.of(context).textTheme.bodySmall,
              filled: true,
              fillColor: Theme.of(context).canvasColor,
              contentPadding: const EdgeInsets.only(left: 20.0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
