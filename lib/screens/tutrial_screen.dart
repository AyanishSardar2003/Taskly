import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:perfect_day/getx/controller.dart';

class TutrialScreen extends StatelessWidget {
  TutrialScreen({super.key});
  final SettingsController settingsController = Get.find();
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [SystemUiOverlay.top],
        );
      },
      child: Scaffold(
          appBar: AppBar(
            title: Container(
              width: 150,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: const Offset(0, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).cardColor),
              padding: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  settingsController.changeLang(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.translate,
                      size: 20,
                    ),
                    Text(
                      'Language'.tr,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () {
                    settingsController.isDarkMode =
                        settingsController.isDarkMode! ? false : true;

                    settingsController.update();
                  },
                  icon: Icon(settingsController.isDarkMode!
                      ? Icons.dark_mode
                      : Icons.light_mode)),
            ],
          ),
          bottomSheet: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeOut(
                duration: const Duration(milliseconds: 250),
                animate: settingsController.seletedIndex == 2 ? true : false,
                child: TextButton(
                    onPressed: settingsController.changeSignIn,
                    child: Text(
                      'skip'.tr,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i <= 2; i++)
                    GetBuilder<SettingsController>(builder: (c) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.linearToEaseOut,
                        margin: const EdgeInsets.all(2),
                        height: 6,
                        width: i == c.seletedIndex ? 24 : 12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: i == c.seletedIndex
                                ? Theme.of(context).primaryColor
                                : Colors.grey),
                      );
                    }),
                ],
              ),
              FadeOut(
                duration: const Duration(milliseconds: 250),
                animate: settingsController.seletedIndex == 2 ? true : false,
                child: IconButton(
                    onPressed: () {
                      pageController.animateToPage(
                          (pageController.page! + 1).round(),
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.linear);
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                    )),
              ),
            ],
          ),
          body: PageView(
            controller: pageController,
            onPageChanged: settingsController.onPageChanged,
            children: [
              _tutrailPage(context, text: 'Welcome to Taskly'.tr, lottie: 't1'),
              _tutrailPage(context, text: 'page2'.tr, lottie: 't6'),
              lastPage(context, text: 'page3'.tr, lottie: 't5'),
            ],
          )),
    );
  }

  Column _tutrailPage(BuildContext context,
      {required String lottie, required String text}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 120,
            child: Lottie.asset('assets/lottie/$lottie.json')),
        const SizedBox(
          height: 32,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        SizedBox(
          height: Get.height * 0.15,
        ),
      ],
    );
  }

  Column lastPage(BuildContext context,
      {required String lottie, required String text}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 120,
            child: Lottie.asset('assets/lottie/$lottie.json')),
        const SizedBox(
          height: 32,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        SizedBox(
          height: Get.height * 0.1,
        ),
        FadeIn(
          duration: const Duration(milliseconds: 100),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.25),
            child: MaterialButton(
              minWidth: 20,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: settingsController.changeSignIn,
              child: Text(
                'Get Started'.tr,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
