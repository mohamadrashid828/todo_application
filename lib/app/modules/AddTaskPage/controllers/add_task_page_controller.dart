import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/app/modules/home/task.dart';

class AddTaskPageController extends GetxController {
  Rx<TextEditingController> Titel =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> Note =
      Rx<TextEditingController>(TextEditingController());
  late Rx<TextEditingController> Date;
  late Rx<TextEditingController> StartTime;
  late Rx<TextEditingController> EndTime;

  late Rx<TextEditingController> Rimindtextcontroler;
  late Rx<List<String>> Repeat;
  late Rx<TextEditingController> repeat_textcontroler;
  late Rx<List<MaterialColor>> color;
  Rx<String> selectcolor = "red".obs;
  final count = 0.obs;
  @override
  void onInit() {
    Date = Rx<TextEditingController>(TextEditingController(
        text: DateFormat.yMd().format(DateTime.now()).toString()));
    StartTime = Rx<TextEditingController>(TextEditingController(
        text: DateFormat("hh:mm a").format(DateTime.now()).toString()));
    EndTime = Rx<TextEditingController>(TextEditingController(
        text: DateFormat("hh:mm a")
            .format(DateTime.now().add(Duration(minutes: 15)))
            .toString()));

    Repeat = Rx<List<String>>(["None", "Daily", "Weekly", "Monthly"]);
    Rimindtextcontroler = Rx<TextEditingController>(
        TextEditingController(text: "5 Minute early"));
    repeat_textcontroler =
        Rx<TextEditingController>(TextEditingController(text: Repeat.value[0]));

    color = Rx<List<MaterialColor>>([Colors.red, Colors.orange, Colors.green]);

    super.onInit();
  }

  Taskclass inputdataTo_Task({required int rimind}) {
    return Taskclass(
      Title: Titel.value.text,
      note: Note.value.text,
      is_completed: 0,
      Date: Date.value.text,
      StartDay: StartTime.value.text,
      EndDay: EndTime.value.text,
      color: selectcolor.value,
      remind: rimind,
      repeat: repeat_textcontroler.value.text,
    );
  }
}
