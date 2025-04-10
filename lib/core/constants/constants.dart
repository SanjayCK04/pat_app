import 'package:flutter/material.dart';
import 'package:pet_app/core/utils/utility_functions.dart';
import 'package:pet_app/domain/responses/dog.dart';
import 'package:pet_app/domain/responses/human.dart';
import 'package:pet_app/presentation/controllers/bottom_bar_controller.dart';
import 'package:pet_app/presentation/controllers/dogs_controller.dart';
import 'package:pet_app/presentation/controllers/home_page_controller.dart';
import 'package:pet_app/presentation/controllers/login_controller.dart';
import 'package:pet_app/presentation/controllers/register_controller.dart';
import 'package:pet_app/presentation/controllers/user_profile_controller.dart';

part 'color_and_gradients.dart';
part 'sizes.dart';
part 'images.dart';
part 'fonts.dart';
part 'dummy_data.dart';
part 'controllers.dart';

BoxShadow buttonShadow = BoxShadow(
  color: const Color.fromARGB(255, 42, 148, 249).withAlpha((0.3 * 255).floor()),
  spreadRadius: 0,
  blurRadius: 24,
  offset: const Offset(0, 6),
);

List<List<String>> pages = [
  ['Home', getImagePath('home_icon')],
  ['Bookings', getImagePath('bookings')],
  ['Search', getImagePath('search_icon')],
  ['Settings', getImagePath('settings_icon')],
];

int currentPageIndex = 0;
