import 'package:flutter/material.dart';
import 'package:pet_app/core/constants/constants.dart';
import 'package:pet_app/core/widgets/common_widgets.dart';

Widget loginOptionButton(String text, BuildContext context, String icon) {
  return makeFilledButton(
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon, width: getWidth(16), height: getHeight(16)),
        SizedBox(width: getWidth(10)),
        makeText(text, context, size: 12, fontFamily: poppins),
      ],
    ),
    () {},
    context,
    isGradient: false,
    width: 120,
    height: 40,
    fillColor: Color.fromARGB(255, 51, 58, 66),

    border: Border.all(
      color: Color.fromARGB((0.7 * 255).floor(), 239, 239, 239),
      width: 0.5,
    ),
    padding: EdgeInsets.zero,
    margin: EdgeInsets.zero,
    shadow: [BoxShadow(color: Colors.transparent)],
  );
}
