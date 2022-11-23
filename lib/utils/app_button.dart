import 'package:base_bloc_flutter/constants/color_constants.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const GradientButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 52.0,
    this.gradient = const LinearGradient(
        colors: [ColorConstants.gradientLeft, ColorConstants.gradientRight]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(8);
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
          color: Colors.amberAccent),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.transparent;
              } else if (states.contains(MaterialState.disabled)) {
                return Colors.white.withOpacity(0.6);
              }
              return Colors.transparent;
            },
          ),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorConstants.white,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
