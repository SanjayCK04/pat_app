import 'package:pet_app/domain/entities/human.dart';

class HumanModel extends Human {
  const HumanModel({
    required super.name,
    super.image,
    required super.distance,
    required super.dogs,
  });
}
