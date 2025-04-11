import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_app/core/utils/utility_functions.dart';

Future<bool> readLoginStatus() async {
  try {
    final box = await Hive.openBox('loginStatusBox');
    bool isLoggedIn = box.get('isLoggedIn', defaultValue: false) as bool;
    return isLoggedIn;
  } catch (e) {
    initHive();
    return readLoginStatus();
  }
}

Future<String> readUserEmail() async {
  final box = await Hive.openBox('loginStatusBox');
  String email = box.get('email', defaultValue: '') as String;
  return email;
}

Future<String> readUserPassword() async {
  final box = await Hive.openBox('loginStatusBox');
  String password = box.get('password', defaultValue: '') as String;
  return password;
}

Future<String> readUserToken() async {
  final box = await Hive.openBox('loginStatusBox');
  String token = box.get('token', defaultValue: '') as String;
  return token;
}

Future<int?> readUserId() async {
  final box = await Hive.openBox('loginStatusBox');
  // If userId is not set, return null. Otherwise, parse to int
  var value = box.get('userId');
  if (value == null) return null;
  return int.tryParse(value.toString()) ?? 180; // Default to 180 if parsing fails
}

Future<void> writeUserId(int userId) async {
  final box = await Hive.openBox('loginStatusBox');
  await box.put('userId', userId);
}

Future<void> writeUserToken(String token) async {
  final box = await Hive.openBox('loginStatusBox');
  await box.put('token', token);
}

Future<bool> readRememberMeStatus() async {
  final box = await Hive.openBox('rememberMeBox');
  bool isRememberMe = box.get('isRememberMe', defaultValue: false) as bool;
  return isRememberMe;
}

Future<void> writeLoginStatus(bool status) async {
  final box = await Hive.openBox('loginStatusBox');
  await box.put('isLoggedIn', status);
}

Future<void> writeRememberMeStatus(bool status) async {
  final box = await Hive.openBox('rememberMeBox');
  await box.put('isRememberMe', status);
}

Future<void> writeUserEmail(String email) async {
  final box = await Hive.openBox('loginStatusBox');
  await box.put('email', email);
}

Future<void> writeUserPassword(String password) async {
  final box = await Hive.openBox('loginStatusBox');
  await box.put('password', password);
}

 
