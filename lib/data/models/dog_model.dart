import 'package:pet_app/domain/responses/dog.dart';

class DogModel extends Dog {
  DogModel({
    required super.id,
    required super.name,
    required super.gender,
    required super.breed,
    required super.age,
    required super.behavior,
    required super.images,
    required super.habits,
    required super.specialNeeds,
    super.isCurrentDog = false,
    super.isLiked = false,
  });
}
