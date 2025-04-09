part of 'home_widgets.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getWidth(50),
      width: getWidth(50),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withAlpha((0.1 * 255).floor()),
            blurRadius: getWidth(20),
            offset: Offset(2, -4),
          ),
        ],
      ),
      child: InnerShadow(
        blur: getWidth(4),
        color: Colors.black.withAlpha((0.45 * 255).floor()),
        offset: Offset(-5, 6),
        child: Container(
          decoration: BoxDecoration(
            gradient: backgroundGradient,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(
              getImagePath('notification_icon'),
              width: getWidth(30),
              height: getWidth(30),
              fit: BoxFit.cover,
              isAntiAlias: true,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ),
    );
  }
}
