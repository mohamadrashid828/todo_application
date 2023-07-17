// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_application/app/thems/themsCoustm.dart';

import '../controllers/notification_screen_controller.dart';

class NotificationScreenView extends GetView<NotificationScreenController> {
    String data;
   NotificationScreenView({
    required this.data,
  }) ;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          elevation: 2,
          title:  Text('Title',style: thems().titelStyle,),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Hello , Mohammad",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                "You have new reminde",
              ),
              Container(
                margin: const EdgeInsets.all(5),
                height: Get.height * 0.7,
                padding: const EdgeInsets.all(25),
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 22, 123, 206),
                    borderRadius: BorderRadius.circular(18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cousstumRow(
                      icon: Icons.text_format,
                      text: "Titel",
                    ),
                     Padding(
                      padding:const EdgeInsets.symmetric(vertical: 15),
                      child: Text(data.toString().split("|")[0],style: thems().Subtext,),
                    ),
                    cousstumRow(
                      icon: Icons.description,
                      text: "Description",
                    ),
                     Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child:Text(data.toString().split("|")[1],style: thems().Subtext),
                    ),
                    cousstumRow(
                      icon: Icons.date_range_outlined,
                      text: "Date",
                    ),
                     Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(data.toString().split("|")[2],style:  thems().Subtext),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
       , floatingActionButton: FloatingActionButton(onPressed: (){
        Get.changeTheme(thems.dark);
    
       }),
        );
  }
}

class cousstumRow extends StatelessWidget {
  String text;
  IconData icon;
  cousstumRow({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            text,
            style: thems().titelStyle
          ),
        ),
      ],
    );
  }
}
