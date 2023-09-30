import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/constants/sizes.dart';

class MoodButton extends ConsumerWidget {
  const MoodButton({
    super.key,
    required this.isSelected,
    required this.text,
    required this.color,
  });

  final String text;
  final bool isSelected;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size5,
      ),
      width: Sizes.size32,
      height: Sizes.size32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(
            Sizes.size5,
          )),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: Sizes.size20,
        ),
      ),
    );
  }
}
