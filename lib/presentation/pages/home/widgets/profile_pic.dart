part of 'home_widgets.dart';

class ProfilePic extends GetView<HomePageController> {
  const ProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withAlpha((0.1 * 255).floor()),
            blurRadius: getWidth(20),
            offset: Offset(8, -4),
          ),
        ],
      ),
      child: InnerShadow(
        blur: getWidth(4),
        color: Colors.black.withAlpha((0.45 * 255).floor()),
        offset: Offset(-4, 8),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: backgroundGradient,
          ),
          padding: EdgeInsets.all(getWidth(10)),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: backgroundGradient,
            ),
            clipBehavior: Clip.hardEdge,
            child: Obx(
              () => Image.asset(
                controller.isDog.value
                    ? currentDog.images[0]
                    : getImagePath('chris_martinen'),
                width: getWidth(180),
                height: getWidth(180),
                fit: BoxFit.cover,
                isAntiAlias: true,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
