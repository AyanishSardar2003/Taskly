import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect_day/screens/archive_screen.dart';
import 'package:perfect_day/screens/details_screen.dart';
import 'package:perfect_day/screens/settings_screen.dart';

import '../../getx/controller.dart';

class CustomAppBar extends StatelessWidget {
  final HomeController controller = Get.find();
  final SettingsController settingsController = Get.put(SettingsController());
  CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      titleSpacing: 0,
      leading: Row(
        children: [
          PopupMenuButton(
              tooltip: 'show menu'.tr,
              iconColor: Colors.white,
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          Get.to(() => SettingsScreen());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              color: settingsController.isDarkMode!
                                  ? Colors.white
                                  : Colors.grey.shade800,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text('settings button'.tr)
                          ],
                        )),
                    PopupMenuItem(
                        onTap: () {
                          Get.to(() => const DetailsScreen());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: settingsController.isDarkMode!
                                  ? Colors.white
                                  : Colors.grey.shade800,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text('about button'.tr)
                          ],
                        )),
                    PopupMenuItem(
                        onTap: () {
                          Get.to(() => ArchiveScreen());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.archive,
                              color: settingsController.isDarkMode!
                                  ? Colors.white
                                  : Colors.grey.shade800,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text('not finish'.tr)
                          ],
                        )),
                    PopupMenuItem(
                        onTap: () {
                          Get.dialog(
                            // Using Material dialog for better control
                            Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Warning icon at the top
                                    const Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 16),
                                    // Title of the dialog
                                    Text(
                                      'dialog delete warning'.tr,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    // Body text giving a message
                                    Text(
                                      'dialog subTitle'.tr,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 24),
                                    // Cancel and Confirm buttons
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // Cancel Button
                                        ElevatedButton(
                                          onPressed: () {
                                            // Close the dialog without action
                                            Get.back();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: Text(
                                            'dialog c button'.tr,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                        // Confirm Button
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.deleteAll();
                                            Get.back();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: Text(
                                            'dialog d button'.tr,
                                            style: const TextStyle(
                                                color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            barrierDismissible:
                                false, // Make it so the dialog can't be dismissed by tapping outside
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              'delete tasks'.tr,
                              style: const TextStyle(color: Colors.red),
                            )
                          ],
                        ))
                  ]),
        ],
      ),
      title: Padding(
        padding: EdgeInsets.only(
            right: settingsController.lang == 'ar' ? 0 : 16,
            left: settingsController.lang == 'ar' ? 16 : 0),
        child: Container(
          height: Get.height * 0.05,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controller) {
                return ZoomIn(
                  child: TextField(
                    onSubmitted: (v) {
                      controller.cloaseSreach();
                    },
                    onTap: controller.searching,
                    controller: controller.searchController,
                    onChanged: controller.onChanged,
                    autofocus: false,
                    style: const TextStyle(color: Colors.black),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: 'hint text field'.tr,
                      hintStyle:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

/* 
 */