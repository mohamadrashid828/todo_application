// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_application/app/thems/themsCoustm.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          title:  Text('Title',style: thems().titelStyle,),
          centerTitle: true,
          backgroundColor: context.theme.scaffoldBackgroundColor,
          leading: IconButton(onPressed: (){
            thems().changeTheme();
           
          }, icon:thems().ChekStateThem()? Icon(Icons.wb_sunny):Icon(Icons.dark_mode_outlined)),
          iconTheme: IconThemeData(color: context.theme.primaryColor),
        ),
        body:null
       , floatingActionButton: FloatingActionButton(onPressed: (){
        print(thems().ChekStateThem());
    
       }),
        );
  }
}

