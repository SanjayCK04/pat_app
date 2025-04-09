part of 'home_widgets.dart';

Widget homeScreenIconContainer(
  Widget child,
  BuildContext context, {
  bool isProfile = false,
  Function? onTap,
}) {
  return Center(
    child: GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: getWidth(40),
        height: getHeight(40),
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: homeButtonBorderGradient,
            width: getWidth(0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.3 * 255).floor()),
              blurRadius: getWidth(24),
              offset: Offset(getWidth(12), getHeight(6)),
            ),
          ],
          gradient: isProfile ? blueGradient : homeButtonGradient,
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    ),
  );
}

Column getHomeScreenIconButtonWithLabel(
  String image,
  String label,
  BuildContext context, {
  bool isProfile = false,
  Function? onTap,
}) {
  return Column(
    children: [
      homeScreenIconContainer(
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(
            image,
            width: getWidth(24),
            height: getWidth(24),
            fit: BoxFit.cover,
            isAntiAlias: true,
            filterQuality: FilterQuality.high,
          ),
        ),
        context,
        onTap: onTap,
        isProfile: isProfile,
      ),
      heightDivider(5),
      makeText(
        label,
        context,
        color: isProfile ? baseBlueColor : Colors.white,
        size: 10,
      ),
    ],
  );
}
