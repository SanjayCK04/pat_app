part of 'common_widgets.dart';

Text makeText(
  String text,
  BuildContext context, {
  double? size,
  Color? color,
  FontWeight? weight,
  TextAlign? align,
  double? letterSpacing,
  String? fontFamily,
}) {
  return Text(
    text,
    textScaler: TextScaler.linear(1.0),
    style: TextStyle(
      fontSize: getHeight(size ?? 16),
      color: color ?? Colors.white,
      fontWeight: weight ?? FontWeight.normal,
      letterSpacing: letterSpacing ?? 0.0,
      fontFamily: fontFamily ?? freedoka,
    ),
    textAlign: align ?? TextAlign.start,
  );
}

class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, required this.gradient});

  final Widget text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback:
          (bounds) => gradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
      child: text,
    );
  }
}

GradientText makeGradientText(
  Widget text,
  BuildContext context, {
  Gradient? gradient,
}) {
  return GradientText(text, gradient: gradient ?? blueGradient);
}
