part of 'utility_functions.dart';

Future<void> initControllerInjections() {
  bottomBarController = Get.put(BottomBarController());
  homePageController = Get.put(HomePageController());
  dogsController = Get.put(DogsController(), tag: 'currentDog');
  loginController = Get.put(LoginController());
  registerController = Get.put(RegisterController());
  return Future.value();
}

Future<void> initHive() async {
  await Hive.initFlutter();
  await Hive.openBox('loginStatusBox');
  await Hive.openBox('rememberMeBox');
}
