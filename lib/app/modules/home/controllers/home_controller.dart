// ignore_for_file: constant_pattern_never_matches_value_type

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/app/data/databaseSQL.dart';
import 'package:todo_application/app/modules/home/task.dart';

class HomeController extends GetxController {
  late DatePickerController datepiker = DatePickerController();
  var tasks1 = <Taskclass>[].obs;
  Rx<DateTime> datetime = Rx<DateTime>(DateTime.now());

  @override
  void onInit() async {
    await FeachTask();
    super.onInit();
  }

  FeachTask() async {
    String date = DateFormat.yMd().format(datetime.value);
    tasks1.clear();
    final res = await db_connection_and_oprator().selectTask();
    // where (Date=? AND repeat="None") OR (repeat="Daily") OR (repeat="Weekly" AND ? ) OR (repeat="Monthly" AND ? )

    //  date,
    tasks1.addAll(res!.where(
      (element) =>
          element.Date == date ||
          element.repeat == "Daily" ||
          (element.repeat == "Weekly" &&
              DateFormat.yMd().parse(date).difference(DateFormat.yMd().parse(element.Date)).inDays %
                      7 ==
                  0) ||
          (element.repeat == "Monthly" &&
              DateTime.now().day == DateFormat.yMd().parse(date).day),
    ));
  }

  MaterialColor changenumbertocolor(String input) {
    switch (input) {
      case "red":
        return Colors.red;
      case "orange":
        return Colors.orange;
      case "green":
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
}
