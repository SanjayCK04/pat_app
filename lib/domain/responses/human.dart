import 'package:pet_app/domain/responses/dog.dart';

class Human {
  const Human({
    required this.name,
    this.image,
    required this.distance,
    required this.dogs,
  });

  final String name;
  final String? image;
  final double distance;
  final List<Dog> dogs;
}
