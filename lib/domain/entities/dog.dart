import 'package:pet_app/core/utils/utility_functions.dart';

class Dog {
  Dog({
    required this.id,
    required this.name,
    required this.gender,
    required this.breed,
    required this.age,
    required this.behavior,
    required this.images,
    required this.habits,
    required this.specialNeeds,
    this.isCurrentDog = false,
    this.isLiked = false,
  });

  final int id;
  final String name;
  final bool gender;
  final String breed;
  final String age;
  final String behavior;
  final List<String> images;
  final String habits;
  final String specialNeeds;
  final bool isCurrentDog;
  bool isLiked;

  String get likedImage =>
      isLiked ? getImagePath('heart_icon_filled') : getImagePath('heart_icon');
}
