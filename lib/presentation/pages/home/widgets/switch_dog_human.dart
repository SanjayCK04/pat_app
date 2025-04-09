part of 'home_widgets.dart';

class SwitchDogHuman extends GetView<HomePageController> {
  const SwitchDogHuman({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.changeValue();
      },
      child: Obx(
        () => Container(
          height: getHeight(26),
          width: getWidth(52),
          padding: EdgeInsets.symmetric(horizontal: getWidth(2), vertical: 0),
          decoration: BoxDecoration(
            color: black,
            borderRadius: BorderRadius.circular(getWidth(20)),
            border: Border.all(
              color: (controller.isDog.value ? baseBlueColor : baseOrangeColor)
                  .withAlpha((0.5 * 255).floor()),
              width: getWidth(0.5),
            ),
          ),
          child: Container(
            alignment:
                controller.isDog.value ? Alignment.topRight : Alignment.topLeft,
            height: getHeight(26),
            width: getWidth(52),
            padding: EdgeInsets.only(top: getHeight(2)),
            child: GradientIcon(
              offset: Offset(0, 0),
              icon: Icons.circle,
              gradient: controller.isDog.value ? blueGradient : orangeGradient,
              size: getHeight(20),
            ),
          ),
        ),
      ),
    );
  }
}
