part of 'profile_widgets.dart';

class MakeProfileIcon extends StatelessWidget {
  const MakeProfileIcon(this.image, this.onPressed, {super.key});

  final String image;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(30),
      height: getWidth(30),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 37, 37, 37),
      ),
      clipBehavior: Clip.hardEdge,
      child: IconButton(
        onPressed: () => onPressed(),
        color: Colors.transparent,
        iconSize: getWidth(9),
        icon: Image.asset(
          image,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          isAntiAlias: true,
        ),
      ),
    );
  }
}
