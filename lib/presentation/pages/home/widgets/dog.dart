part of 'home_widgets.dart';

Widget dogTile(int dog, BuildContext context) {
  return Expanded(
    child: GestureDetector(
      onTap: () async {
        Get.find<DogsController>(
          tag: 'currentDog',
        ).changeDog(dogsList[dog].obs);
        Get.to(
          ProfileScreen(),
          transition: Transition.cupertino,
          duration: const Duration(milliseconds: 500),
        );
      },
      child: Card(
        shadowColor: Colors.black.withAlpha((0.5 * 255).floor()),
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(getWidth(20)),
                  topRight: Radius.circular(getWidth(20)),
                ),
              ),
              child: Image.asset(dogsList[dog].images[0], fit: BoxFit.cover),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB((0.15 * 255).floor(), 96, 170, 254),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(getWidth(10)),
                  bottomRight: Radius.circular(getWidth(10)),
                ),
              ),
              padding: EdgeInsets.fromLTRB(
                getWidth(10),
                getHeight(6),
                getWidth(10),
                getHeight(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        getImagePath('dog_icon'),
                        height: getHeight(14),
                        fit: BoxFit.cover,
                      ),
                      widthDivider(7.46),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          makeText(
                            'Name',
                            context,
                            size: 7,
                            color: baseOrangeColor,
                          ),
                          makeText(
                            dogsList[dog].name,
                            context,
                            size: 10,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                  heightDivider(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            getImagePath('gender_icon'),
                            width: getHeight(14),
                            height: getHeight(14),
                            fit: BoxFit.cover,
                          ),
                          widthDivider(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              makeText(
                                'Gender',
                                context,
                                size: 7,
                                color: baseOrangeColor,
                              ),
                              makeText(
                                dogsList[dog].gender ? 'Male' : 'Female',
                                context,
                                size: 10,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            getImagePath('age_icon'),
                            width: getHeight(14),
                            height: getHeight(14),
                            fit: BoxFit.cover,
                          ),
                          widthDivider(7.46),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              makeText(
                                'Age',
                                context,
                                size: 7,
                                color: baseOrangeColor,
                              ),
                              makeText(
                                dogsList[dog].age,
                                context,
                                size: 10,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget explore(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            makeText('Explore', context, size: 20, weight: FontWeight.w500),
            GestureDetector(
              onTap: () {},
              child: makeText(
                'View All',
                context,
                size: 14,
                weight: FontWeight.w300,
                color: baseOrangeColor,
              ),
            ),
          ],
        ),
        heightDivider(10),
        Column(
          children: [
            for (int i = 1; i < dogsList.length; i += 2)
              Column(
                children: [
                  Row(
                    children: [
                      dogTile(i, context),
                      widthDivider(20),
                      if (i + 1 < dogsList.length) dogTile(i + 1, context),
                    ],
                  ),
                  heightDivider(20),
                ],
              ),
            heightDivider(50),
          ],
        ),
      ],
    ),
  );
}
