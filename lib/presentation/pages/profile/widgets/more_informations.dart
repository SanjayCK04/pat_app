part of 'profile_widgets.dart';

Widget moreInformationTile(
  String infoTitle,
  BuildContext context,
  String infoData,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      makeText(
        infoTitle,
        context,
        size: 18,
        weight: FontWeight.w600,
        color: baseOrangeColor,
      ),
      heightDivider(4),
      makeText(
        infoData,
        context,
        size: 16,
        weight: FontWeight.w400,
        color: Colors.white,
      ),
    ],
  );
}

Widget divider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: getHeight(14)),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.white.withAlpha((0.1 * 255).floor()),
          width: getWidth(1),
        ),
      ),
    ),
  );
}

Widget moreInformationContainer(BuildContext context, Dog dog) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      moreInformationTile('Breed', context, dog.breed),
      divider(),
      moreInformationTile('Behavior', context, dog.behavior),
      divider(),
      moreInformationTile('Habits', context, dog.habits),
      divider(),
      moreInformationTile('Special Needs', context, dog.specialNeeds),
      divider(),
    ],
  );
}
