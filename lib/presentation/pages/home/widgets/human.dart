part of 'home_widgets.dart';

Widget makeHumanTile(Human human, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Container(
            height: getHeight(36),
            width: getHeight(36),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  human.image == null
                      ? GradientBoxBorder(
                        gradient: homeButtonBorderGradient,
                        width: getWidth(0.5),
                      )
                      : Border.all(color: Colors.white, width: getWidth(1)),
              gradient: blueGradient,
            ),
            child:
                human.image == null
                    ? Center(
                      child: makeText(
                        human.name[0],
                        context,
                        size: 24,
                        weight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    )
                    : Image.asset(
                      human.image!,
                      width: getHeight(36),
                      height: getHeight(36),
                      isAntiAlias: true,
                      filterQuality: FilterQuality.high,
                    ),
          ),
          widthDivider(16.5),
          makeText(
            human.name,
            context,
            size: 16,
            color: Colors.white,
            letterSpacing: getWidth(0.5),
          ),
        ],
      ),
      Row(
        children: [
          Image.asset(
            getImagePath('location'),
            width: getWidth(12),
            fit: BoxFit.fitWidth,
            isAntiAlias: true,
            filterQuality: FilterQuality.high,
          ),
          widthDivider(5),
          makeText(
            '${human.distance}km',
            context,
            size: 14,
            color: Colors.white,
            weight: FontWeight.w300,
          ),
        ],
      ),
    ],
  );
}

Widget findAMember(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
    child: Column(
      children: [
        Row(
          children: [
            makeText(
              'Find a Member',
              context,
              size: 20,
              weight: FontWeight.w500,
              align: TextAlign.left,
            ),
          ],
        ),
        heightDivider(10),
        Column(
          children: [
            for (int i = 0; i < humansList.length; i++)
              Column(
                children: [
                  makeHumanTile(humansList[i], context),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: getHeight(11)),
                    decoration: BoxDecoration(
                      border: GradientBoxBorder(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withAlpha(0),
                            Colors.white.withAlpha((0.5 * 255).floor()),
                            Colors.white.withAlpha(0),
                          ],
                        ),
                        width: getHeight(0.5),
                      ),
                    ),
                    width: getWidth(350),
                  ),
                ],
              ),
          ],
        ),

        heightDivider(19),
        makeText('View All', context, size: 16, color: baseOrangeColor),
      ],
    ),
  );
}
