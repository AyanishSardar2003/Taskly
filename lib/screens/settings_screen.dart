import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:perfect_day/sql/sqldb.dart';

import '../getx/controller.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  Sqldb sqldb = Sqldb();
  final SettingsController settingsController = Get.find();
  final HomeController homeController = Get.find();
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [SystemUiOverlay.top],
        );
      },
      child: Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            'App Version: v1.0.0'.tr,
            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 11),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text('setting title'.tr),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'theme'.tr,
                style:
                    TextStyle(fontSize: 12, color: Theme.of(context).hintColor),
              ),
              GetBuilder<SettingsController>(
                  init: SettingsController(),
                  builder: (controller) {
                    return SwitchListTile(
                        secondary: Icon(controller.isDarkMode!
                            ? Icons.dark_mode
                            : Icons.light_mode),
                        title: Text(
                          'Dark Mode'.tr,
                          style: const TextStyle(fontSize: 14),
                        ),
                        activeColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        value: controller.isDarkMode!,
                        onChanged: controller.toggleTheme);
                  }),
              InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () async {
                    Color newColor = await showColorPicker(
                        context, settingsController.selectedColor.value);
                    settingsController.saveColor(newColor);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.color_lens),
                    title: Text('Display Color'.tr),
                  )),
              const Divider(
                thickness: 0.5,
              ),
              Text('Text'.tr,
                  style: TextStyle(
                      color: Theme.of(context).dividerColor, fontSize: 10)),
              InkWell(
                child: GetBuilder<SettingsController>(
                    init: SettingsController(),
                    builder: (controller) {
                      return ListTile(
                        trailing: PopupMenuButton(
                            elevation: 1,
                            position: PopupMenuPosition.under,
                            itemBuilder: (c) => [
                                  PopupMenuItem(
                                    height: 40,
                                    child: Row(
                                      children: [
                                        const Text('🇱🇾'),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text('Arabic'.tr),
                                      ],
                                    ),
                                    onTap: () {
                                      controller.changeLocal('ar');
                                      homeController.tPriority = 'Midum'.tr;
                                    },
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      controller.changeLocal('en');
                                      homeController.tPriority = 'Midum'.tr;
                                    },
                                    height: 40,
                                    child: Row(
                                      children: [
                                        const Text('🇺🇸'),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text('English'.tr),
                                      ],
                                    ),
                                  )
                                ],
                            child: const Icon(Icons.arrow_drop_down)),
                        leading: const Icon(Icons.translate),
                        title: Text(
                          'Language'.tr,
                          style: const TextStyle(fontSize: 14),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      );
                    }),
              ),
              InkWell(
                child: ListTile(
                  trailing: PopupMenuButton(
                      elevation: 1,
                      position: PopupMenuPosition.under,
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              height: 40,
                              child: const Text('Default'),
                              onTap: () {
                                settingsController.changeFont('Default');
                              },
                            ),
                            PopupMenuItem(
                              onTap: () {
                                settingsController.changeFont('Almarai');
                              },
                              height: 40,
                              child: const Text('Almarai'),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                settingsController.changeFont('Ubuntu');
                              },
                              height: 40,
                              child: const Text('Ubuntu'),
                            )
                          ],
                      child: const Icon(Icons.arrow_drop_down)),
                  leading: const Icon(Icons.font_download),
                  title: Text(
                    'Font Style'.tr,
                    style: const TextStyle(fontSize: 14),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const Divider(
                thickness: 0.5,
              ),
              Text('System'.tr,
                  style: TextStyle(
                      color: Theme.of(context).dividerColor, fontSize: 10)),
              GetBuilder<SettingsController>(
                  init: SettingsController(),
                  builder: (controller) {
                    return SwitchListTile(
                        secondary: const Icon(Icons.notifications_active),
                        title: Text(
                          'Notifications'.tr,
                          style: const TextStyle(fontSize: 14),
                        ),
                        activeColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        value: true,
                        onChanged: (v) {});
                  }),
              const Divider(
                thickness: 0.5,
              ),
              Text('Application'.tr,
                  style: TextStyle(
                      color: Theme.of(context).dividerColor, fontSize: 10)),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                child: ListTile(
                  leading: const Icon(
                    CupertinoIcons.star,
                  ),
                  title: Text(
                    "Rate the app on the store".tr,
                  ),
                ),
                onTap: () {},
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                child: ListTile(
                  leading: const Icon(
                    CupertinoIcons.share_solid,
                  ),
                  title: Text(
                    'Share Application'.tr,
                  ),
                ),
                onTap: () {},
              ),
              InkWell(
                onTap: () {
                  sqldb.deleteApp();
                },
                borderRadius: BorderRadius.circular(10),
                child: ListTile(
                  leading: const Icon(
                    CupertinoIcons.delete_solid,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Delete Data'.tr,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Color> showColorPicker(
      BuildContext context, Color currentColor) async {
    Color selected = currentColor;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Select a Color".tr,
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {
                selected = color;
              },
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Ok".tr,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ),
            ),
          ],
        );
      },
    );

    return selected;
  }
}
