import 'package:amazon/utils/colors_theme.dart';
import 'package:flutter/material.dart';

enum CustomButtonColor { primary, secondary, danger, dark, warning }

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  CustomButtonColor? color;
  final bool? isLoading;

  CustomButton({
    super.key,
    this.color,
    this.isLoading,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Color colorSelector() {
      switch (color) {
        case CustomButtonColor.primary:
          return yellowColor;
        case CustomButtonColor.secondary:
          return activeCyanColor;
        case CustomButtonColor.danger:
          return const Color.fromARGB(255, 203, 37, 34);
        case CustomButtonColor.dark:
          return const Color.fromARGB(255, 190, 190, 190);
        case CustomButtonColor.warning:
          return const Color.fromARGB(255, 240, 240, 11);
        default:
          return Colors.orange;
      }
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorSelector(),
      ),
      child: isLoading ?? false
          ? const AspectRatio(
              aspectRatio: 1 / 1,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Color.fromARGB(179, 79, 79, 79),
                ),
              ),
            )
          : child,
    );
  }
}
