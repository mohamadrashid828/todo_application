import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoustonmWidget {
  
  mybutton(BuildContext ctx,
      {required double width,
      required double hight,
      required Function function,
      Color? color,
      Widget? icon,
      Widget? text}) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        width: width,
        height: hight,
        decoration: BoxDecoration(
            color: color ?? ctx.theme.colorScheme.secondary,
            boxShadow: [
              const BoxShadow(blurRadius: 0.2, blurStyle: BlurStyle.outer)
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: icon == null || text == null
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceAround,
          children: [icon ?? Container(), text ?? Container()],
        ),
      ),
    );
  }
  
}