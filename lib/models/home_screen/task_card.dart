import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../getx/controller.dart';
import 'my_task_card.dart';

class TaskCard extends StatelessWidget {
  TaskCard({
    super.key,
  });
  final ValueNotifier<Map<int, double>> itemHeights = ValueNotifier({});

  final HomeController homeController = Get.find();
  final SettingsController settingsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: Get.height * 0.1),
                height: Get.height * 0.855,
                color: Theme.of(context).primaryColor,
              ),
              Obx(
                () => Container(
                  margin: EdgeInsets.only(
                    top: Get.height * 0.1,
                  ),
                  height: Get.height * 0.855,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              settingsController.lang == 'ar' ? 27.5 : 0),
                          topRight: Radius.circular(
                              settingsController.lang == 'ar' ? 0 : 27.5))),
                  child: homeController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : homeController.data.isEmpty
                          ? homeController.isSearch.value ||
                                  homeController
                                      .searchController.text.isNotEmpty
                              ? Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      homeController.isSearch.value
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: homeController.isSearch.value
                                          ? Get.height * 0.1
                                          : 0,
                                    ),
                                    ZoomIn(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.search_off,
                                            color: Colors.grey,
                                            size: 80,
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            'no task found'.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24.0),
                                            child: Text(
                                              'no task found subTitle'.tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : homeController.signIn == 0
                                  ? Center(
                                      child: Text(
                                          'Press (add button) to add a task!.'
                                              .tr),
                                    )
                                  : ZoomIn(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            height: 200,
                                            child: Lottie.asset(
                                              'assets/lottie/1.json',
                                              animate:
                                                  homeController.data.isEmpty,
                                              repeat: false,
                                            ),
                                          ),
                                          Text(
                                            'done all tasks'.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .color),
                                          ),
                                        ],
                                      ),
                                    )
                          : ZoomIn(
                              child: ListView.builder(
                                itemCount: homeController.data.length,
                                padding: EdgeInsets.fromLTRB(
                                    16, 16, 16, Get.height * 0.1),
                                itemBuilder: (context, index) => Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: counters(index, context)),
                                    // ignore: prefer_const_constructors
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex: 30,
                                      child: MyTaskCard(
                                          index: index,
                                          homeController: homeController,
                                          itemHeights: itemHeights),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                ),
              ),
              Container(
                height: Get.height * 0.1,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(
                            settingsController.lang == 'ar' ? 27.5 : 0),
                        bottomLeft: Radius.circular(
                            settingsController.lang == 'ar' ? 0 : 27.5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => homeController.isSearch.value
                              ? const SizedBox()
                              : Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      strokeWidth: 3.5,
                                      valueColor: const AlwaysStoppedAnimation(
                                          Colors.white),
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.6),
                                      value: homeController.progres(),
                                    ),
                                    Text(
                                      "%${(homeController.progres() * 100).toStringAsFixed(0)}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'my tasks'.tr,
                          style: const TextStyle(
                              fontSize: 30, color: Colors.white),
                        ),
                      ],
                    ),
                    PopupMenuButton(
                        tooltip: 'show menu'.tr,
                        elevation: 1,
                        position: PopupMenuPosition.under,
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  homeController.onSort(0);
                                  FocusScope.of(context).unfocus();
                                },
                                height: 40,
                                child: Text(
                                  'Priority'.tr,
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  homeController.onSort(1);
                                  FocusScope.of(context).unfocus();
                                },
                                height: 40,
                                child: Text(
                                  'title'.tr,
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  homeController.onSort(2);
                                  FocusScope.of(context).unfocus();
                                },
                                height: 40,
                                child: Text(
                                  'default'.tr,
                                ),
                              )
                            ],
                        child: Row(
                          children: [
                            Text(
                              'sort'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ValueListenableBuilder<Map<int, double>> counters(
      int index, BuildContext context) {
    return ValueListenableBuilder<Map<int, double>>(
        valueListenable: itemHeights,
        builder: (context, heights, child) {
          final height = heights[index] ?? 0;
          double x = (height * 0.49);
          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.linear,
                width: 2,
                height: x,
                color: index == 0
                    ? Colors.transparent
                    : homeController.data[index - 1]['isDone'] == 0
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
              ),
              AnimatedContainer(
                curve: Curves.linear,
                duration: const Duration(milliseconds: 250),
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 2,
                      color: homeController.data[index]['isDone'] == 0
                          ? Colors.grey
                          : Theme.of(context).primaryColorDark),
                  color: homeController.data[index]['isDone'] == 0
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).primaryColor,
                ),
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                      color: homeController.data[index]['isDone'] == 1
                          ? Colors.white
                          : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              AnimatedContainer(
                curve: Curves.linear,
                duration: const Duration(milliseconds: 250),
                width: homeController.data.length == index + 1 ? 0 : 2,
                height: x,
                color: homeController.data.length == index + 1
                    ? Colors.transparent
                    : homeController.data[index]['isDone'] == 0
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
              ),
            ],
          );
        });
  }
}


/*
   
 */
