import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_application/app/thems/themsCoustm.dart';

import 'app/routes/app_pages.dart';

void main() async{
      await GetStorage.init();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      themeMode:thems().currentthem,
      theme: thems.light,
      darkTheme: thems.dark,
    ),
  );
}
