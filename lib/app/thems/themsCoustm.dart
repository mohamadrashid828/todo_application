// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class thems extends GetxController {
  String _key = "isdark";
  GetStorage box = GetStorage();

  bool ChekStateThem() {
    return box.read<bool>(_key) ?? false;
  }

  void changeTheme() {
    if (ChekStateThem()) {
      Get.changeTheme(thems.light);
        box.write(_key,false);
    } else {
      Get.changeTheme(thems.dark);
        box.write(_key, true);
    }
   
  }

  ThemeMode get currentthem =>
      ChekStateThem() ? ThemeMode.dark : ThemeMode.light;
  static ThemeData light = ThemeData(
        disabledColor: Colors.black38,
      brightness: Brightness.light,
      primaryColor: const Color.fromARGB(255, 15, 15, 15),
      scaffoldBackgroundColor: const Color.fromARGB(255, 250, 246, 231));

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    disabledColor: Color.fromARGB(255, 230, 227, 227),
    primaryColor: const Color.fromARGB(255, 247, 242, 242),
  );

  TextStyle get titelStyle => TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: !Get.isDarkMode ? Colors.black : Colors.white);

  TextStyle get Subtext => TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: !Get.isDarkMode ? Colors.black : Colors.white);
}
