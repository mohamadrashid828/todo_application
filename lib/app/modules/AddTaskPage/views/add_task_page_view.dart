// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/app/cusstomWidgget/cusstomWidget.dart';
import 'package:todo_application/app/data/databaseSQL.dart';
import 'package:todo_application/app/modules/home/controllers/home_controller.dart';
import 'package:todo_application/app/thems/themsCoustm.dart';

import '../controllers/add_task_page_controller.dart';

class AddTaskPageView extends GetView<AddTaskPageController> {
  AddTaskPageView({Key? key}) : super(key: key);
  int remind_value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              CircleAvatar(
                  minRadius: 25,
                  child: CircleAvatar(
                    minRadius: 23,
                    child: Icon(
                      Icons.person,
                      color: context.theme.primaryColor,
                    ),
                    backgroundColor: context.theme.scaffoldBackgroundColor,
                  ))
            ],
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: context.theme.primaryColor),
            backgroundColor: context.theme.scaffoldBackgroundColor),
        body: SingleChildScrollView(
          child: Center(
              child: Obx(() => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Add Task",
                          style: thems().Subtext,
                        ),
                      ),
                      InputTextFormFild(
                        Hint: "Enter Titel Here",
                        Lable: "Title",
                        controller1: controller.Titel.value,
                      ),
                      InputTextFormFild(
                        Hint: "Enter Note Here",
                        Lable: "Note",
                        controller1: controller.Note.value,
                      ),
                      InputTextFormFild(
                        Hint: "",
                        Lable: "Date",
                        controller1: controller.Date.value,
                        widget: IconButton(
                            onPressed: () async {
                              final res = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2030));
                              if (res != null) {
                                controller.Date.value.text =
                                    DateFormat.yMd().format(res).toString();
                              }
                            },
                            icon: const Icon(Icons.date_range_outlined)),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InputTextFormFild(
                              Hint: "",
                              Lable: "Start Date",
                              controller1: controller.StartTime.value,
                              widget: IconButton(
                                  onPressed: () async {
                                    final res = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now());
                                    if (res != null) {
                                      controller.StartTime.value.text =
                                          DateFormat("hh:mm a")
                                              .format(DateTime(1, 1, 1,
                                                  res.hour, res.minute))
                                              .toString()
                                              .toString();
                                    }
                                  },
                                  icon: const Icon(Icons.timer_outlined)),
                            ),
                          ),
                          Expanded(
                            child: InputTextFormFild(
                              Hint: "",
                              Lable: "End Date",
                              controller1: controller.EndTime.value,
                              widget: IconButton(
                                  onPressed: () async {
                                    final res = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now());
                                    if (res != null) {
                                      controller.EndTime.value.text =
                                          DateFormat("hh:mm a")
                                              .format(DateTime(1, 1, 1,
                                                  res.hour, res.minute))
                                              .toString()
                                              .toString();
                                    }
                                  },
                                  icon: const Icon(Icons.timer_outlined)),
                            ),
                          ),
                        ],
                      ),
                      InputTextFormFild(
                          Hint: "",
                          Lable: "Riminde",
                          controller1: controller.Rimindtextcontroler.value,
                          widget: DropdownButton(
                              elevation: 0,
                              borderRadius: BorderRadius.circular(10),
                              dropdownColor: Colors.grey,
                              style: const TextStyle(color: Colors.white),
                              items: List.generate(5, (e) => 5 * e + 3)
                                  .map<DropdownMenuItem<int>>((e) =>
                                      DropdownMenuItem(
                                          value: e,
                                          child: Text("$e minute early")))
                                  .toList(),
                              onChanged: (value) {
                                remind_value = value!;
                                controller.Rimindtextcontroler.value.text =
                                    "$value minute early";
                              })),
                      InputTextFormFild(
                          Hint: "",
                          Lable: "Reapet",
                          controller1: controller.repeat_textcontroler.value,
                          widget: DropdownButton(
                              elevation: 0,
                              borderRadius: BorderRadius.circular(10),
                              dropdownColor: Colors.grey,
                              style: const TextStyle(color: Colors.white),
                              items: controller.Repeat.value
                                  .map<DropdownMenuItem<String>>((e) =>
                                      DropdownMenuItem(
                                          value: e, child: Text("$e")))
                                  .toList(),
                              onChanged: (value) {
                                controller.repeat_textcontroler.value.text =
                                    "$value";
                              })),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Color",
                                  style: thems().Subtext,
                                ),
                                Row(
                                  children: [
                                    ...controller.color.value.map<Widget>((e) =>
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              controller.selectcolor.value =
                                                  colortoString(e);
                                            },
                                            child: CircleAvatar(
                                                backgroundColor: e,
                                                child: HomeController()
                                                            .changenumbertocolor(
                                                                controller
                                                                    .selectcolor
                                                                    .value) ==
                                                        e
                                                    ? const Icon(Icons.check)
                                                    : null),
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            CoustonmWidget().mybutton(context,
                                width: 100, hight: 40, function: () {
                              db_connection_and_oprator().Validationtextfild(
                                  title: controller.Titel.value.text,
                                  note: controller.Note.value.text,
                                  task: controller.inputdataTo_Task(
                                      rimind: remind_value));
                            },
                                text: const Text("Add task",
                                    style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      )
                    ],
                  ))),
        ));
  }

  String colortoString(MaterialColor e) {
    switch (e) {
      case Colors.red:
        return "red";
      case Colors.orange:
        return "orange";
      case Colors.green:
        return "green";
      default:
        return "red";
    }
  }
}

class InputTextFormFild extends StatelessWidget {
  String Hint;

  String Lable;
  TextEditingController controller1;
  Widget? widget;
  InputTextFormFild({
    Key? key,
    required this.Hint,
    required this.Lable,
    required this.controller1,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Lable, style: thems().Subtext),
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: context.theme.primaryColor),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    readOnly: widget != null,
                    controller: controller1,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(), hintText: Hint),
                  ),
                ),
                widget ?? Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
