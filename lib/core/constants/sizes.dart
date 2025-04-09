part of 'constants.dart';

const double refWidth = 390;
const double refHeight = 844;

late double screenWidth;
late double screenHeight;

late double heightRatio;
late double widthRatio;

double getHeight(double height) {
  return height * heightRatio;
}

double getWidth(double width) {
  return width * widthRatio;
}
