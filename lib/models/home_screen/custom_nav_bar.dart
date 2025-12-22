import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getx/controller.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return AnimatedBottomNavigationBar(
          height: Get.height * 0.07,
          inactiveColor: Colors.grey,
          activeColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          gapLocation: GapLocation.center,
          gapWidth: 0,
          icons: const [
            CupertinoIcons.house_fill,
            Icons.attach_money,
          ],
          activeIndex: homeController.selectedIndexNav,
          onTap: (index) {
            homeController.changeSelectedIndex(index);
          });
    });
  }
}
