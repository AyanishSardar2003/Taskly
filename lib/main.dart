import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perfect_day/getx/controller.dart';
import 'package:perfect_day/getx/local/local.dart';

import 'package:perfect_day/screens/splash_screen.dart';

import 'package:perfect_day/screens/tutrial_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (controller) {
          return Obx(
            () => GetMaterialApp(
              locale: controller.intialLang,
              translations: MyLocal(),
              debugShowCheckedModeBanner: false,
              title: 'Taskly',
              darkTheme: ThemeData.dark().copyWith(
                  primaryColorLight: Colors.white,
                  datePickerTheme: DatePickerThemeData(
                    dayBackgroundColor:
                        WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        // Customize the background color for the selected day
                        return controller.selectedColor.value;
                      }
                      return Colors
                          .transparent; // Default background color for unselected days
                    }),
                    weekdayStyle: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                    confirmButtonStyle: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.resolveWith((states) {
                        return controller.selectedColor.value;
                      }),
                      foregroundColor:
                          WidgetStateProperty.resolveWith((states) {
                        return Colors.white;
                      }),
                    ),
                    cancelButtonStyle: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.resolveWith((states) {
                        return Colors.red; // Red color for cancel button
                      }),
                      foregroundColor:
                          WidgetStateProperty.resolveWith((states) {
                        return Colors.white;
                      }),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  textTheme: TextTheme(
                    bodyLarge: TextStyle(
                        fontFamily: controller.font, color: Colors.white),
                    bodyMedium: TextStyle(fontFamily: controller.font),
                    displayLarge: TextStyle(fontFamily: controller.font),
                    displayMedium: TextStyle(fontFamily: controller.font),
                    displaySmall: TextStyle(fontFamily: controller.font),
                    headlineMedium: TextStyle(fontFamily: controller.font),
                    headlineLarge: TextStyle(fontFamily: controller.font),
                    headlineSmall: TextStyle(fontFamily: controller.font),
                    titleLarge: TextStyle(fontFamily: controller.font),
                    titleMedium: TextStyle(fontFamily: controller.font),
                    titleSmall: TextStyle(fontFamily: controller.font),
                    bodySmall: TextStyle(fontFamily: controller.font),
                    labelLarge: TextStyle(fontFamily: controller.font),
                    labelSmall: TextStyle(fontFamily: controller.font),
                    labelMedium: TextStyle(fontFamily: controller.font),
                  ),
                  cardColor: const Color(0xFF1B1B1B),
                  primaryColor: controller.selectedColor.value,
                  timePickerTheme: TimePickerThemeData(
                    dialTextStyle: TextStyle(fontFamily: controller.font),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    dialHandColor: controller.selectedColor.value,
                    dayPeriodColor: controller.selectedColor.value,
                    hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
                      return states.contains(WidgetState.selected)
                          ? controller.selectedColor.value
                          : Colors.white70;
                    }),
                    hourMinuteColor: WidgetStateColor.resolveWith((states) {
                      return states.contains(WidgetState.selected)
                          ? controller.selectedColor.value.withOpacity(0.2)
                          : Colors.grey.shade800;
                    }),
                    confirmButtonStyle: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.resolveWith((states) {
                        return controller.selectedColor.value;
                      }),
                      foregroundColor:
                          WidgetStateProperty.resolveWith((states) {
                        return Colors.white;
                      }),
                    ),
                    cancelButtonStyle: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.resolveWith((states) {
                        return Colors.red;
                      }),
                      foregroundColor:
                          WidgetStateProperty.resolveWith((states) {
                        return Colors.white;
                      }),
                    ),
                  ),
                  primaryColorDark:
                      controller.selectedColor.value.withOpacity(0.5),
                  bottomSheetTheme: const BottomSheetThemeData(
                      backgroundColor: Colors.transparent)),
              theme: ThemeData.light().copyWith(
                primaryColorLight: Colors.black,
                datePickerTheme: DatePickerThemeData(
                  dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      // Customize the background color for the selected day
                      return controller.selectedColor.value;
                    }
                    return Colors
                        .transparent; // Default background color for unselected days
                  }),
                  weekdayStyle: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                  confirmButtonStyle: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      return controller.selectedColor.value;
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      return Colors.white;
                    }),
                  ),
                  cancelButtonStyle: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      return Colors.red; // Red color for cancel button
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      return Colors.white;
                    }),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                timePickerTheme: TimePickerThemeData(
                  helpTextStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                  confirmButtonStyle: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      return controller.selectedColor.value;
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      return Colors.white;
                    }),
                  ),
                  cancelButtonStyle: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      return Colors.red;
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      return Colors.white;
                    }),
                  ),
                  dialTextStyle: TextStyle(fontFamily: controller.font),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  dialHandColor: controller.selectedColor.value,
                  dayPeriodColor: controller.selectedColor.value,
                  hourMinuteTextColor: WidgetStateColor.resolveWith((states) =>
                      states.contains(WidgetState.selected)
                          ? controller.selectedColor.value
                          : Colors.black),
                  hourMinuteColor: WidgetStateColor.resolveWith((states) =>
                      states.contains(WidgetState.selected)
                          ? controller.selectedColor.value.withOpacity(0.2)
                          : Colors.grey.shade200),
                ),
                textTheme: TextTheme(
                  bodyLarge: TextStyle(
                      fontFamily: controller.font, color: Colors.black),
                  bodyMedium: TextStyle(fontFamily: controller.font),
                  displayLarge: TextStyle(fontFamily: controller.font),
                  displayMedium: TextStyle(fontFamily: controller.font),
                  displaySmall: TextStyle(fontFamily: controller.font),
                  headlineMedium: TextStyle(fontFamily: controller.font),
                  headlineSmall: TextStyle(fontFamily: controller.font),
                  headlineLarge: TextStyle(fontFamily: controller.font),
                  labelMedium: TextStyle(fontFamily: controller.font),
                  titleLarge: TextStyle(fontFamily: controller.font),
                  titleMedium: TextStyle(fontFamily: controller.font),
                  titleSmall: TextStyle(fontFamily: controller.font),
                  bodySmall: TextStyle(fontFamily: controller.font),
                  labelLarge: TextStyle(fontFamily: controller.font),
                  labelSmall: TextStyle(fontFamily: controller.font),
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                ),
                scaffoldBackgroundColor: Colors.white,
                primaryColor: controller.selectedColor.value,
                primaryColorDark:
                    controller.selectedColor.value.withOpacity(0.5),
                bottomSheetTheme: const BottomSheetThemeData(
                    backgroundColor: Colors.transparent),
              ),
              themeMode:
                  controller.isDarkMode! ? ThemeMode.dark : ThemeMode.light,
              home: controller.signIn == 0
                  ? TutrialScreen()
                  : const SplashScreen(),
            ),
          );
        });
  }
}
