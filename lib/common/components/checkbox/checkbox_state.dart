class CheckBoxState<T> {
  const CheckBoxState({
    required this.isChecked,
    required this.value,
  });

  final bool isChecked;
  final T value;
}
