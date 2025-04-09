part of 'profile_widgets.dart';

Widget basicInfoContainer(
  String infoTitle,
  String infoData,
  BuildContext context,
) {
  return Container(
    width: getWidth(100),
    height: getHeight(60),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB((0.15 * 255).floor(), 96, 170, 254),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        makeText(
          infoTitle,
          context,
          size: 16,
          weight: FontWeight.w600,
          color: baseOrangeColor,
        ),
        heightDivider(5),
        makeText(
          infoData,
          context,
          size: 14,
          weight: FontWeight.w400,
          color: Colors.white,
        ),
      ],
    ),
  );
}
