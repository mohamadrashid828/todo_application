import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPageController extends GetxController {
  Rx<TextEditingController> Titel =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> Note =
      Rx<TextEditingController>(TextEditingController());
  late Rx<TextEditingController> Date;
  late Rx<TextEditingController> StartTime;
  late Rx<TextEditingController> EndTime;
  late List<int> Rimind;
  late Rx<TextEditingController> Rimindtextcontroler ;
  late Rx<List<String>> Repeat;
    late Rx<TextEditingController> repeat_textcontroler ;
    late Rx<List<MaterialColor>> color;
   var selectcolor=Colors.green.obs;
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
    Rimind = [
      5,
      10,
      15,
      30,
      50,
    ];
    Repeat=  Rx<List<String>>(["None","Daily","weakly","Monthly"]);
    Rimindtextcontroler =
      Rx<TextEditingController>(TextEditingController(text: "5 Minute early"));
        repeat_textcontroler =
      Rx<TextEditingController>(TextEditingController(text: Repeat.value[0]));
  
  color=Rx<List<MaterialColor>>([Colors.red,Colors.orange,Colors.green]);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
