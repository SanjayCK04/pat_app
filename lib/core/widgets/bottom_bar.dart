part of 'common_widgets.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.3 * 255).floor()),
            blurRadius: getWidth(24),
            offset: -Offset(getWidth(12), getHeight(6)),
          ),
        ],
      ),
      child: Container(
        height: getHeight(80),
        padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
        width: screenWidth,
        decoration: BoxDecoration(
          gradient: backgroundForBottomBarGradient,
          boxShadow: [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < pages.length; i++)
              TextButton(
                onPressed: () {
                  bottomBarController.changeIndex(i);
                },
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Image.asset(
                        pages[i][1],
                        width: getHeight(24),
                        fit: BoxFit.fitWidth,
                        isAntiAlias: true,
                        filterQuality: FilterQuality.high,
                        color:
                            bottomBarController.currentIndex.value == i
                                ? baseBlueColor
                                : Colors.white,
                      ),
                    ),
                    heightDivider(7),
                    Obx(
                      () => makeText(
                        bottomBarController.currentIndex.value == i
                            ? pages[i][0].toUpperCase()
                            : pages[i][0],
                        context,
                        size: 10,
                        color:
                            bottomBarController.currentIndex.value == i
                                ? baseBlueColor
                                : Colors.white,
                        weight:
                            bottomBarController.currentIndex.value == i
                                ? FontWeight.w600
                                : FontWeight.w400,
                        letterSpacing: getWidth(1),
                      ),
                    ),
                    heightDivider(10),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
