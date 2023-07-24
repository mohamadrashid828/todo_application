// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/app/cusstomWidgget/cusstomWidget.dart';
import 'package:todo_application/app/data/databaseSQL.dart';
import 'package:todo_application/app/modules/home/task.dart';
import 'package:todo_application/app/routes/app_pages.dart';
import 'package:todo_application/app/thems/themsCoustm.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        leading: IconButton(
            onPressed: () {
              thems().changeTheme();
            },
            icon: thems().ChekStateThem()
                ? const Icon(Icons.wb_sunny)
                : const Icon(Icons.dark_mode_outlined)),
        iconTheme: IconThemeData(color: context.theme.primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() => Column(
              children: [
                // CoustonmWidget().mybutton(context,
                //     width: 100, hight: 35, text: Text("add task"), function: () {
                //       Get.toNamed(Routes.ADD_TASK_PAGE);
                //     }),
                _addTaskbar(context),
                _addDateBar(context),
                _showTask(context),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // controller.FeachTask(DateTime.now());

        // db_connection_and_oprator().insertTask(Taskclass(
        //     Title: "Title",
        //     note: "note",
        //     is_completed: 0,
        //     Date: DateFormat("hh:mm a").format(DateTime.now()).toString(),
        //     StartDay: DateFormat("hh:mm a").format(DateTime.now()).toString(),
        //     EndDay: DateFormat("hh:mm a").format(DateTime.now()).toString(),
        //     color: "green",
        //     remind: 15,
        //     repeat: "none"));
        //  scheduleLocalNotification(DateTime.now().add(Duration(seconds: 20)), flutterLocalNotificationsPlugin1);
        // print(thems().ChekStateThem());
      }),
    );
  }

  _addTaskbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: thems().titelStyle,
            ),
            Text("Today", style: thems().Subtext)
          ],
        ),
        CoustonmWidget().mybutton(context, width: 100, hight: 40, function: () {
          Get.toNamed(Routes.ADD_TASK_PAGE)?.then((value) {controller.FeachTask();} );
        }, text: const Text("Add Task"), icon: const Icon(Icons.add))
      ],
    );
  }

  _addDateBar(BuildContext ctx) {
    return Container(
      width: Get.width,
      child: DatePicker(
          controller: controller.datepiker,
          daysCount: 35,
          width: 50,
          initialSelectedDate: DateTime.now(),
          monthTextStyle:
              TextStyle(color: ctx.theme.disabledColor, fontSize: 10),
          dayTextStyle: TextStyle(color: ctx.theme.disabledColor, fontSize: 14),
          dateTextStyle:
              TextStyle(color: ctx.theme.disabledColor, fontSize: 16),
          selectionColor: ctx.theme.colorScheme.secondary,
          DateTime.now(),
          onDateChange: (date)async{
            controller.datetime.value=date;
           await controller.FeachTask();
          },
          ),
          
    );
  }

  _showTask(BuildContext ctx) {
    return controller.tasks1.isEmpty
        ? ifnohave_any_task(ctx)
        : Expanded(
            child: Container(
              child: Obx(() => RefreshIndicator(
                onRefresh: () {return Future.delayed(Duration(seconds: 1),() => controller.FeachTask(),);},
                child: ListView.builder(
                    itemCount: controller.tasks1.length,
                    itemBuilder: (context, snapshot) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () {
                            print(DateFormat.yMd().format(DateTime.now()) == DateFormat.yMd().parse(controller.tasks1[snapshot].Date).day);
                            bottomNavigattionbar(
                                context, controller.tasks1[snapshot]);
                              
                          },
                          child: _TaskTile(
                              ctx: ctx, task: controller.tasks1[snapshot]),
                        ))),
              )),
            ),
          );
  }

  //it usetd to show notification


  _TaskTile({required BuildContext ctx, required Taskclass task}) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: controller.changenumbertocolor(task.color),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Row(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.Title),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                            Text("  ${task.StartDay}   _  ${task.EndDay}")
                          ],
                        ),
                      ),
                      Text(task.note),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 0.5,
                    height: 50,
                    decoration: const BoxDecoration(color: Colors.grey)),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Text(task.is_completed == 1 ? "Completed" : "To Do"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ifnohave_any_task(BuildContext ctx) {
    return const Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(seconds: 2),
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                SizedBox(
                  height: 135,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.note_add_outlined,
                      size: 75, color: Color.fromARGB(169, 158, 158, 158)),
                ),
                Text(
                  "You do not have any task yet .\nadd new task to make your days prodective",
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bottomNavigattionbar(BuildContext ctx, Taskclass task) {
    Get.bottomSheet(
      
      ignoreSafeArea: true,
      elevation: 5,
      Container(
        height: task.is_completed == 1 ? 180 : 235,
        decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              task.is_completed == 1
                  ? Container()
                  : CoustonmWidget().mybutton(ctx,
                      width: Get.width * 0.8,
                      hight: 60,
                      function: () async{
                       await db_connection_and_oprator().UpdateTask(task.id!);
                      Get.back();
                        controller.FeachTask();
                      },
                      text: const Text(
                        "Complede Task",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CoustonmWidget().mybutton(ctx,
                    width: Get.width * 0.8,
                    hight: 60,
                    function: () {
                      db_connection_and_oprator().DelettTask(id: task.id!);
                      Get.back();
                              controller.FeachTask();
                    },
                    text: const Text(
                      "Delete Task",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              CoustonmWidget().mybutton(ctx,
                  width: Get.width * 0.8,
                  hight: 60,
                  function: () async {
                    Get.back();
                  },
                  text: const Text(
                    "Cancel",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
