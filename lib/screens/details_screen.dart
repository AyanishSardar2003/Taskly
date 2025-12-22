import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  static bool exitPage = false;
  const DetailsScreen({
    super.key,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return GestureDetector(
      onTap: () {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [SystemUiOverlay.top],
        );
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: false,
          scrolledUnderElevation: 0,
          toolbarHeight: height * 0.074,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'about button'.tr,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: height * 0.35,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 150,
                      ),
                      const Text(
                        'Taskly',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "1".tr,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: height * 0.53,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  "2".tr,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            fetures("3".tr, Icons.task_alt),
                            fetures(
                              "4".tr,
                              Icons.design_services,
                            ),
                            fetures(
                              "5".tr,
                              Icons.dark_mode,
                            ),
                            fetures(
                              "6".tr,
                              Icons.notifications,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Text
                                    Text(
                                      "7".tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                                FAQItem(
                                  question: "q1".tr,
                                  answer: "a1".tr,
                                ),
                                FAQItem(
                                  question: "q2".tr,
                                  answer: "a2".tr,
                                ),
                                FAQItem(
                                  question: "q3".tr,
                                  answer: "a3".tr,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding fetures(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(
            width: 4,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade600),
          )
        ],
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            answer,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }
}
