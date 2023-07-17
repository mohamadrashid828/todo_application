import 'package:get/get.dart';

import '../modules/AddTaskPage/bindings/add_task_page_binding.dart';
import '../modules/AddTaskPage/views/add_task_page_view.dart';
import '../modules/NotificationScreen/bindings/notification_screen_binding.dart';
import '../modules/NotificationScreen/views/notification_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME
  ;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TASK_PAGE,
      page: () =>  AddTaskPageView(),
      binding: AddTaskPageBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_SCREEN,
      page: () =>  NotificationScreenView(data:"hello|woeld|2/2/2022"),
      binding: NotificationScreenBinding(),
    ),
  ];
}
