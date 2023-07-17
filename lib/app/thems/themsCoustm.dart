// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class thems extends GetxController {
  String _key="isdark";
  GetStorage  box = GetStorage() ;

  bool  ChekStateThem(){
   return box.read<bool>(_key)??false;
  }   
 void changeTheme(){
  box.write(_key, !ChekStateThem());
   ChekStateThem()? Get.changeTheme(thems.dark): Get.changeTheme(thems.light);
 }
  ThemeMode get currentthem=>ChekStateThem()?ThemeMode.dark:ThemeMode.light;
  static ThemeData light = ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color.fromARGB(255, 15, 15, 15),
      scaffoldBackgroundColor: const Color.fromARGB(255, 250, 246, 231));

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
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
