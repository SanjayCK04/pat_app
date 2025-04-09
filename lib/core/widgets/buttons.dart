part of 'common_widgets.dart';

Container makeOutinedButton(
  Widget text,
  VoidCallback onClick,
  BuildContext context, {
  double? width,
  double? height,
  EdgeInsets? margin,
  EdgeInsets? padding,
  BorderRadius? borderRadius,
  Color? fillColor,
  Border? border,
}) {
  return Container(
    width: getWidth(width ?? 350),
    height: getHeight(height ?? 60),
    margin: margin ?? EdgeInsets.symmetric(horizontal: getWidth(20)),
    decoration: BoxDecoration(
      color: fillColor,
      border: border ?? Border.all(color: baseBlueColor, width: getWidth(1)),
      borderRadius: borderRadius ?? BorderRadius.circular(getWidth(10)),
    ),
    child: TextButton(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(7),
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        overlayColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return baseBlueColor.withAlpha(40);
          }
          return Colors.transparent;
        }),
      ),
      onPressed: onClick,
      child: Center(child: makeGradientText(text, context)),
    ),
  );
}

Container makeFilledButton(
  Widget text,
  VoidCallback onClick,
  BuildContext context, {
  Color? fillColor,
  double? width,
  double? height,
  EdgeInsets? margin,
  EdgeInsets? padding,
  BorderRadius? borderRadius,
  Gradient? gradient,
  Border? border,
  List<BoxShadow>? shadow,
  bool isGradient = true,
}) {
  return Container(
    width: getWidth(width ?? 350),
    height:
        height == null
            ? getHeight(60)
            : height == 0
            ? null
            : getHeight(height),
    margin: margin ?? EdgeInsets.symmetric(horizontal: getWidth(20)),
    decoration: BoxDecoration(
      border: border,
      color: fillColor,
      gradient: isGradient ? gradient ?? blueGradient : null,
      borderRadius: borderRadius ?? BorderRadius.circular(getWidth(10)),
      boxShadow: shadow ?? [buttonShadow],
    ),
    child: TextButton(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        overlayColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return (fillColor ?? baseBlueColor)
                .withAlpha(100)
                .withRed(((fillColor ?? baseBlueColor).b).floor() + 5);
          }
          return Colors.transparent;
        }),
      ),
      onPressed: onClick,
      child: Center(child: text),
    ),
  );
}
