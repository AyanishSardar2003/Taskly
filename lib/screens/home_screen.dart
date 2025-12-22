import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:perfect_day/getx/controller.dart';

import 'package:perfect_day/screens/add_task_screen.dart';

import '../models/home_screen/custom_app_bar.dart';

import '../models/home_screen/task_card.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeController.cloaseSreach();

        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [SystemUiOverlay.top],
        );
      },
      child: Scaffold(
          floatingActionButtonLocation: Get.locale?.languageCode == 'ar'
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {
                Get.to(
                    () => AddTaskScreen(
                          id: 0,
                          isDone: 0,
                          isUpdate: false,
                          dateTime: '',
                          timeOfDay: '',
                          title: 'add screen title'.tr,
                          homeController: homeController,
                        ),
                    transition: Transition.downToUp);
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              )),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(Get.height * 0.055),
              child: CustomAppBar()),
          body: TaskCard()),
    );
  }
}
