import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:perfect_day/getx/controller.dart';
import 'package:perfect_day/screens/add_task_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MyTaskCard extends StatelessWidget {
  MyTaskCard(
      {super.key,
      required this.homeController,
      required this.itemHeights,
      required this.index});
  final int index;
  final HomeController homeController;
  final ValueNotifier<Map<int, double>> itemHeights;
  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
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
      key: Key("${homeController.data[index]['id']}"),
      onDismissed: (direction) {
        homeController.delete(index);
      },
      child: GestureDetector(
        onLongPress: goToEditMode,
        child: MeasureHeight(
          onChange: (height) {
            itemHeights.value = {
              ...itemHeights.value,
              index: height,
            };
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: homeController.data[index]['isDone'] == 0
                    ? Theme.of(context).cardColor
                    : Theme.of(context).primaryColor.withOpacity(0.4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                        homeController.data[index]['isDone'] == 0
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
                    homeController.onTap(index);
                  },
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                          color: homeController.data[index]['isDone'] == 0
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).primaryColor,
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle),
                      child: homeController.data[index]['isDone'] == 1
                          ? Icon(
                              Icons.done,
                              color: homeController.data[index]['isDone'] == 0
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : Colors.white,
                            )
                          : homeController.data[index]['priority'] == 'High'
                              ? const Icon(Icons.star)
                              : Icon(
                                  Icons.done,
                                  color:
                                      homeController.data[index]['isDone'] == 0
                                          ? Theme.of(context)
                                              .scaffoldBackgroundColor
                                          : Colors.white,
                                )),
                ),
                title: Text(
                  homeController.data[index]['title'],
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).primaryColorLight),
                ),
                subtitle: Text(
                  homeController.data[index]['subTitle'],
                  style: const TextStyle(fontSize: 12, wordSpacing: 0),
                ),
                trailing: GestureDetector(
                  onTap: goToEditMode,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(formatTimeOfDayString(
                          homeController.data[index]['date'])),
                      const SizedBox(height: 2),
                      Text(
                        _formatDateTime(homeController.data[index]['dateTime']),
                        style: const TextStyle(fontSize: 8.5),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  void goToEditMode() {
    homeController.titleController.text = homeController.data[index]['title'];
    homeController.subTitleController.text =
        homeController.data[index]['subTitle'];

    homeController.groupValue = homeController.data[index]['priority'];
    homeController.tPriority =
        homeController.textPriority(homeController.data[index]['priority']);

    homeController.repet = homeController.data[index]['repet'];
    homeController.selectedDate =
        parseDateTimeString(homeController.data[index]['dateTime']);
    homeController.selectedTime =
        parseTimeString(homeController.data[index]['date']);
    Get.to(AddTaskScreen(
      isDone: homeController.data[index]['isDone'],
      isUpdate: true,
      id: homeController.data[index]['id'],
      dateTime: homeController.data[index]['dateTime'],
      timeOfDay: homeController.data[index]['date'],
      homeController: homeController,
      title: 'update screen title'.tr,
    ));
  }

  TimeOfDay parseTimeString(String timeString) {
    try {
      List<String> timeParts = timeString.split(":");

      if (timeParts.length != 2) {
        throw const FormatException("Invalid time format");
      }

      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);

      return TimeOfDay(hour: hour, minute: minute);
    } catch (_) {
      return TimeOfDay.now();
    }
  }

  DateTime parseDateTimeString(String dateTimeString) {
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS");

    try {
      return format.parse(dateTimeString);
    } catch (e) {
      return DateTime.now();
    }
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

class MeasureHeight extends StatelessWidget {
  final Widget child;
  final Function(double height) onChange;

  const MeasureHeight({super.key, required this.child, required this.onChange});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      if (box.hasSize) {
        onChange(box.size.height);
      }
    });

    return child;
  }
}
