import 'package:get/get.dart';
import 'package:pet_app/core/constants/constants.dart';
import 'package:pet_app/domain/responses/dog.dart';

class DogsController extends GetxController {
  Rx<Dog> dog = dogsList[0].obs;
  RxBool isLiked = dogsList[0].isLiked.obs;
  changeLike() {
    dog.value.isLiked = !dog.value.isLiked;
    isLiked.value = !isLiked.value;
  }

  changeDog(Rx<Dog> newDog) {
    dog.value = newDog.value;
    isLiked.value = newDog.value.isLiked;
  }
}
