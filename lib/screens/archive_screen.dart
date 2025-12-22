import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect_day/getx/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ArchiveScreen extends StatelessWidget {
  ArchiveScreen({super.key});
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('not finish'.tr),
          actions: [
            IconButton(
                onPressed: () {
                  homeController.archive.clear();
                  homeController.box
                      .write('archive', homeController.archive.toList());
                },
                icon: const Icon(
                  CupertinoIcons.delete_solid,
                  color: Colors.red,
                ))
          ],
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Obx(
          () => ZoomIn(
            child: homeController.archive.isEmpty
                ? Center(
                    child: Text(
                      'nothing'.tr,
                      style:
                          TextStyle(color: Theme.of(context).primaryColorLight),
                    ),
                  )
                : ListView.builder(
                    itemCount: homeController.archive.length,
                    padding: EdgeInsets.fromLTRB(16, Get.height * 0.05, 16, 0),
                    itemBuilder: (context, index) => ArchiveCard(
                        homeController: homeController, index: index)),
          ),
        ));
  }
}

class ArchiveCard extends StatelessWidget {
  ArchiveCard({super.key, required this.homeController, required this.index});
  final int index;
  final HomeController homeController;

  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.15),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.delete_solid,
              color: Colors.red,
            ),
            const SizedBox(width: 8),
            Text('deleting task'.tr, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
      direction: DismissDirection.startToEnd,
      key: Key("${homeController.archive[index]['id']}"),
      onDismissed: (direction) {
        homeController.removeFromArchive(index);
      },
      child: GestureDetector(
        child: AnimatedContainer(
          margin: const EdgeInsets.symmetric(vertical: 8),
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: homeController.archive[index]['isDone'] == 0
                  ? Theme.of(context).cardColor
                  : Theme.of(context).primaryColor.withOpacity(0.4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                      homeController.archive[index]['isDone'] == 0
                          ? 0.25
                          : 0.075),
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0, 1),
                ),
              ],
              borderRadius: BorderRadius.circular(25)),
          child: ListTile(
              leading: ZoomTapAnimation(
                onTap: () {
                  DateTime now = DateTime.now();
                  homeController.addItemFromArchive(
                      title: homeController.archive[index]['title'],
                      subTitle: homeController.archive[index]['subTitle'],
                      repet: homeController.archive[index]['repet'],
                      date: DateTime(now.year, now.month, now.day + 1),
                      time: homeController.archive[index]['date'],
                      priority: homeController.archive[index]['priority']);
                  homeController.removeFromArchive(index);
                },
                child: const Icon(Icons.restart_alt),
              ),
              title: Text(
                homeController.archive[index]['title'],
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).primaryColorLight),
              ),
              subtitle: Text(
                homeController.archive[index]['subTitle'],
                style: const TextStyle(fontSize: 12, wordSpacing: 0),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(formatTimeOfDayString(
                      homeController.archive[index]['date'])),
                  const SizedBox(height: 2),
                  Text(
                    _formatDateTime(homeController.archive[index]['dateTime']),
                    style: const TextStyle(fontSize: 8.5),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  String formatTimeOfDayString(String timeString) {
    String timeWithoutPrefix =
        timeString.replaceAll("TimeOfDay(", "").replaceAll(")", "");

    List<String> parts = timeWithoutPrefix.split(':');

    if (parts.length == 2) {
      try {
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);

        DateTime dateTime = DateTime(2025, 1, 1, hour, minute);

        String formattedTime = DateFormat('h:mm a').format(dateTime);
        if (settingsController.lang == 'ar') {
          formattedTime =
              formattedTime.replaceAll('AM', 'ص').replaceAll('PM', 'م');
        }
        return formattedTime;
      } catch (e) {
        return "Invalid time format";
      }
    } else {
      return "Invalid time format";
    }
  }

  String _formatDateTime(String dateTime) {
    try {
      DateTime parsedDate = DateTime.parse(dateTime);
      return DateFormat("E, MMM d, yyyy").format(parsedDate);
    } catch (e) {
      return dateTime;
    }
  }
}
