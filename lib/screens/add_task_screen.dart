import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:perfect_day/getx/controller.dart';
import 'package:perfect_day/sql/sqldb.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen(
      {super.key,
      required this.isDone,
      required this.isUpdate,
      required this.homeController,
      required this.title,
      required this.id,
      required this.dateTime,
      required this.timeOfDay});
  final HomeController homeController;
  final String title;
  final int id;
  final int isDone;
  final String dateTime;
  final String timeOfDay;
  final bool isUpdate;
  final SettingsController settingsController = Get.find();
  final Sqldb sql = Sqldb();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log("${homeController.data}");
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top]);
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: false,
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(fontSize: 28),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              homeController.backToPage();
              FocusScope.of(context).unfocus();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.12, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(
                context,
                controller: homeController.titleController,
                hintText: 'task title'.tr,
                icon: Icons.bookmark_outline,
                minLines: 1,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                context,
                controller: homeController.subTitleController,
                hintText: 'task subTitle'.tr,
                icon: Icons.description_outlined,
                minLines: 6,
              ),
              const SizedBox(height: 16),
              picker(
                context,
                priority: false,
                isTime: true,
              ),
              const SizedBox(height: 16),
              picker(
                context,
                priority: false,
                isTime: false,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: picker(
                      context,
                      priority: true,
                      isTime: false,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  checkRepet(context),
                ],
              )
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MaterialButton(
            minWidth: Get.width * 0.4,
            height: Get.height * 0.055,
            color: Theme.of(context).primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onPressed: () async {
              if (isUpdate) {
                if (homeController.titleController.text.trim().isEmpty ||
                    homeController.subTitleController.text.trim().isEmpty) {
                  Get.snackbar(
                      'Missing Fields'.tr, 'Please fill in all the fields'.tr);
                  return;
                }
                try {
                  String time = homeController.selectedTime.format(context);
                  if (settingsController.lang == 'ar') {
                    time = time.replaceAll('AM', 'ص').replaceAll('PM', 'م');
                  }
                  await sql.updateData(
                      '''update tasks set title ='${homeController.titleController.text}',
                       subTitle = '${homeController.subTitleController.text}',
                       dateTime = '${(homeController.selectedDate)}',
                       date = '${homeController.selectedTime.hour}:${homeController.selectedTime.minute}',
                       priority ='${homeController.groupValue}',
                       repet = ${homeController.repet}
                       where id = $id ''');
                  homeController.repet = 0;
                  homeController.groupValue = "Medium";
                  homeController.fetchData();
                  homeController.backToPage();
                } catch (_) {
                  Get.snackbar('Error', 'Failed to add task');
                }
              } else {
                homeController.addItem(context);
              }
            },
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  TextField _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required int minLines,
  }) {
    return TextField(
      controller: controller,
      cursorColor: Theme.of(context).primaryColor,
      minLines: minLines,
      maxLines: minLines,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).cardColor,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
        ),
      ),
    );
  }

  Container picker(
    BuildContext context, {
    required bool isTime,
    required bool priority,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: InkWell(
        onTap: () {
          if (isTime) {
            homeController.changeSelectedTime(context);
          } else if (priority) {
            homeController.selectPriority(context);
          } else {
            homeController.changeSelectedDate(context);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                priority
                    ? 'Priority'.tr
                    : isTime
                        ? 'time'.tr
                        : 'date'.tr,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(1),
                  borderRadius: BorderRadius.circular(13)),
              child: GetBuilder<HomeController>(builder: (c) {
                String formattedTime = c.selectedTime.format(context);

                String formattedDate =
                    DateFormat("E, MMM d, yyyy").format(c.selectedDate);
                if (settingsController.lang == 'ar') {
                  formattedTime =
                      formattedTime.replaceAll('AM', 'ص').replaceAll('PM', 'م');
                }
                return Text(
                  priority
                      ? (c.tPriority)
                      : isTime
                          ? formattedTime
                          : formattedDate,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Container checkRepet(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: InkWell(
        onTap: homeController.changeRepetState,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Text(
                'Repet'.tr,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
            ),
            ZoomTapAnimation(
              onTap: homeController.changeRepetState,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(1),
                    ),
                    borderRadius: BorderRadius.circular(9)),
                child: GetBuilder<HomeController>(builder: (c) {
                  return Icon(
                    Icons.done,
                    color: c.repet == 0
                        ? Colors.transparent
                        : Theme.of(context).primaryColor,
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
