part of 'constants.dart';

Color baseBlueColor = const Color.fromARGB(255, 96, 170, 254);

Color baseOrangeColor = const Color.fromARGB(255, 254, 135, 67);

LinearGradient orangeGradient = LinearGradient(
  colors: [baseOrangeColor, Color.fromARGB(255, 190, 93, 38)],
);

LinearGradient blueGradient = LinearGradient(
  colors: [
    const Color.fromARGB(255, 42, 146, 246),
    const Color.fromARGB(255, 48, 121, 208),
  ],
);

RadialGradient backgroundGradient = RadialGradient(
  center: Alignment(0.50, 0.50),
  radius: 0.65,
  colors: [Color.fromARGB(255, 54, 54, 54), Color.fromARGB(255, 37, 37, 37)],
);
RadialGradient backgroundForBottomBarGradient = RadialGradient(
  center: Alignment(0.52, 0.51),
  radius: 1.73,
  colors: [Color.fromARGB(255, 54, 54, 54), Color.fromARGB(255, 37, 37, 37)],
);

Color inputBoxColor = Color.fromARGB(255, 54, 61, 69);

LinearGradient homeButtonGradient = LinearGradient(
  colors: [
    Color.fromARGB((0.12 * 255).floor(), 255, 255, 255),
    Color.fromARGB((0.06 * 255).floor(), 255, 255, 255),
  ],
);

LinearGradient homeButtonBorderGradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 204, 204, 204),
    Color.fromARGB(0, 255, 255, 255),
  ],
);

Color black = const Color.fromARGB(255, 24, 24, 24);
