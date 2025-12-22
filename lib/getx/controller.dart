import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perfect_day/screens/home_screen.dart';

import '../sql/sqldb.dart';

class HomeController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final SettingsController settingsController = Get.put(SettingsController());
  int? signIn;
  TimeOfDay selectedTime = TimeOfDay.now();
  String tPriority = 'Midum'.tr;

  textPriority(String val) {
    switch (val) {
      case 'NLow':
        return 'Low'.tr;
      case 'Medium':
        return 'Midum'.tr;
      case 'High':
        return 'High'.tr;
      default:
        return 'Midum'.tr;
    }
  }

  void selectPriority(BuildContext context) async {
    await Get.bottomSheet(
        isDismissible: true,
        enableDrag: true,
        Container(
          height: Get.height * 0.35,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    height: 4,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Priority'.tr,
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColorLight),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _radioListTile(context, title: 'High'.tr, value: 'High'),
                  _radioListTile(context, title: 'Midum'.tr, value: 'Medium'),
                  _radioListTile(context, title: 'Low'.tr, value: 'NLow'),
                ],
              ),
            ],
          ),
        ));
  }

  String groupValue = 'Medium';
  GetBuilder<HomeController> _radioListTile(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return GetBuilder<HomeController>(builder: (controller) {
      return RadioListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          activeColor: Theme.of(context).primaryColor,
          title: Text(title),
          value: value,
          groupValue: controller.groupValue,
          onChanged: (val) {
            groupValue = val!;
            tPriority = textPriority(val);
            update();
          });
    });
  }

  void changeSelectedTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        helpText: 'Select Time'.tr,
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial);
    if (timeOfDay != null) {
      selectedTime = timeOfDay;
      update();
    }
  }

  DateTime selectedDate = DateTime.now();
  void changeSelectedDate(BuildContext context) async {
    final DateTime? timeOfDay = await showDatePicker(
      helpText: 'Select Date'.tr,
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (timeOfDay != null) {
      selectedDate = timeOfDay;
      update();
    }
  }

  var ho = 2.obs;
  var isLoading = true.obs;
  var isSearch = false.obs;
  onChanged(String title) {
    if (searchController.text.isEmpty) {
      data.assignAll(allData);
    } else {
      data.value = allData
          .where((item) => item['title']
              .toString()
              .toLowerCase()
              .contains(title.toLowerCase()))
          .toList();
    }
  }

  void cloaseSreach() {
    isSearch.value = false;
  }

  void searching() {
    isSearch.value = true;
  }

  Sqldb sql = Sqldb();
  int selectedIndexNav = 0;
  changeSelectedIndex(int index) {
    selectedIndexNav = index;

    update();
  }

  void onTap(index) async {
    int x = data[index]['isDone'] == 0 ? 1 : 0;

    sql.updateData(
        "UPDATE tasks SET isDone = $x WHERE id =${data[index]['id']}");

    await fetchData();
  }

  void removeFromArchive(int index) {
    archive.removeAt(index);

    box.write('archive', archive.toList());
  }

  final box = GetStorage();
  var data = <Map>[].obs;
  var archive = <Map>[].obs;
  List<Map> allData = [];
  var doneData = <Map>[].obs;
  double progres() {
    doneData.assignAll(data.where((test) => test['isDone'] == 1));
    return data.isNotEmpty ? doneData.length / data.length : 0.0;
  }

  void onSort(int n) async {
    ho.value = n;
    await fetchData();
  }

  Future fetchData() async {
    List<Map> res = ho.value == 0
        ? await sql.readData("SELECT * FROM tasks ORDER BY priority")
        : ho.value == 1
            ? await sql.readData("SELECT * FROM tasks ORDER BY title")
            : await sql.readData("SELECT * FROM tasks");
    data.assignAll(res);
    allData.assignAll(res);
  }

  int repet = 0;
  void changeRepetState() {
    repet = repet == 0 ? 1 : 0;
    update();
  }

  Future<void> addItemFromArchive(
      {required String title,
      required String subTitle,
      required String priority,
      required DateTime date,
      required int repet,
      required String time}) async {
    try {
      await sql.insertData(
        "INSERT INTO tasks (title, subTitle, dateTime, date, isDone,priority,repet) VALUES ('$title', '$subTitle', '$date', '$time',0,'$priority',$repet)",
      );

      await fetchData();

      backToPage();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add task $e');
    }
  }

  Future<void> addItem(BuildContext context) async {
    if (titleController.text.trim().isEmpty ||
        subTitleController.text.trim().isEmpty) {
      Get.snackbar('Missing Fields'.tr, 'Please fill in all the fields'.tr);
      return;
    }

    try {
      //String dateTime = DateFormat("E, MMM d, yyyy").format(selectedDate);
      //  String time = selectedTime.format(context);
      String title = titleController.text.trim();
      String subTitle = subTitleController.text.trim();
      String dateTime = "$selectedDate";
      String time = "$selectedTime".toString();
      String value = groupValue;
      if (settingsController.lang == 'ar') {
        time = time.replaceAll('AM', 'ص').replaceAll('PM', 'م');
      }
      signIn = 1;
      box.write('first', 1);
      await sql.insertData(
        "INSERT INTO tasks (title, subTitle, dateTime, date, isDone,priority,repet) VALUES ('$title', '$subTitle', '$dateTime', '${selectedTime.hour}:${selectedTime.minute}',0,'$value',$repet)",
      );
      await fetchData();

      backToPage();
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  void backToPage() {
    selectedTime = TimeOfDay.now();
    selectedDate = DateTime.now();
    titleController.clear();
    subTitleController.clear();
    repet = 0;
    Get.back();
  }

  void loadArchive() {
    List<dynamic>? storedArchive = box.read<List>('archive');

    if (storedArchive != null) {
      archive.assignAll(storedArchive.map((e) => e as Map).toList());
    }
  }

  Future delete(int index) async {
    await sql.deleteData("DELETE FROM tasks WHERE id =${data[index]['id']}");

    data.removeAt(index);

    await fetchData();
  }

  Future deleteAll() async {
    await sql.deleteData("DELETE FROM tasks WHERE id >0");
    data.remove;
    allData.remove;

    await fetchData();
  }

  void tt(int id) async {
    await sql.deleteData('DELETE FROM tasks where id = $id');
  }

  Future<void> addRepetedTasks(
      {required DateTime dateTime,
      required int isDone,
      required int id}) async {
    await sql.updateData('''
    UPDATE tasks set dateTime = '$dateTime',isDone = $isDone where id = $id
''');
  }

  v() async {
    int x = 0;
    DateTime now = DateTime.now();
    await Future.delayed(const Duration(seconds: 1), () async {
      try {
        await Future.delayed(const Duration(seconds: 1), () {
          archive.addAll(data.where((item) {
            DateTime archiveDateTime = DateTime.parse(item['dateTime']);
            if (x < 1 &&
                archiveDateTime
                    .isBefore(DateTime(now.year, now.month, now.day)) &&
                item['repet'] == 0) {
              Get.snackbar(
                  "Incomplete Tasks!".tr,
                  "Non-repeating incomplete tasks have been moved to the archive list."
                      .tr);
              x++;
            }
            return archiveDateTime
                    .isBefore(DateTime(now.year, now.month, now.day)) &&
                item['repet'] == 0;
          }));
          box.write('archive', archive.toList());
          data.removeWhere((item) {
            DateTime itemDateTime = DateTime.parse(item['dateTime']);
            if (itemDateTime.isBefore(DateTime(now.year, now.month, now.day)) &&
                item['repet'] == 0) {
              tt(item['id']);
            }
            if (itemDateTime.isBefore(DateTime(now.year, now.month, now.day)) &&
                item['repet'] == 1) {
              addRepetedTasks(
                  dateTime: DateTime(now.year, now.month, now.day + 1, now.hour,
                      now.minute, now.second, now.millisecond),
                  isDone: 0,
                  id: item['id']);
            }

            return itemDateTime
                    .isBefore(DateTime(now.year, now.month, now.day)) &&
                item['repet'] == 0;
          });
        });
        fetchData();
      } catch (e) {
        Get.snackbar(
          "Error",
          "$e",
        );
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    signIn = box.read('first') ?? 0;
    // expiredItem();
    fetchData();
    log('$data');
    v();
    loadArchive();

    isLoading.value = false;
  }
}

class SettingsController extends GetxController {
  int? signIn;
  changeSignIn() {
    signIn = 1;
    GetStorage().write('signIn', signIn);
    Get.off(() => HomeScreen());
  }

  int seletedIndex = 0;
  onPageChanged(int index) {
    seletedIndex = index;
    update();
  }

  changeLang(BuildContext context) async {
    await Get.bottomSheet(
        isDismissible: true,
        enableDrag: true,
        Container(
          height: Get.height * 0.25,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey),
              ),
              Column(
                children: [
                  _changeLanguage(
                    context,
                    widget: Row(children: [
                      const Text(
                        '🇱🇾',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('Arabic'.tr, style: const TextStyle(fontSize: 16)),
                    ]),
                    value: 'ar',
                  ),
                  _changeLanguage(
                    context,
                    widget: Row(children: [
                      const Text(
                        '🇺🇸',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('English'.tr, style: const TextStyle(fontSize: 16)),
                    ]),
                    value: 'en',
                  ),
                ],
              ),
              Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent),
              ),
            ],
          ),
        ));
  }

  RadioListTile<String> _changeLanguage(BuildContext context,
      {required String value, required Widget widget}) {
    return RadioListTile(
        title: widget,
        activeColor: Theme.of(context).primaryColor,
        value: value,
        groupValue: groupValue,
        onChanged: (val) {
          groupValue = val!;
          changeLocal(val);
          lang = val;
          Get.back();
        });
  }

  var selectedColor = Rx<Color>(Colors.blue);
  String font = (GetStorage().read('font') == null ||
          GetStorage().read('font') == 'Default')
      ? 'Almarai'
      : GetStorage().read('font') == 'Roboto'
          ? 'Roboto'
          : GetStorage().read('font') == 'Ubuntu'
              ? 'Ubuntu'
              : 'Almarai';

  void changeFont(String f) {
    GetStorage().write('font', f);
    font = f;
    update();
  }

  toggleTheme(value) {
    isDarkMode = value;
    GetStorage().write('isDarkMode', value);
    update();
  }

  bool? isDarkMode;
  void saveColor(Color color) {
    GetStorage().write('selectedColor', color.value); // حفظ اللون
    selectedColor.value = color; // تحديث اللون
  }

  String? lang;
  Locale intialLang = GetStorage().read('ln') == null
      ? Get.deviceLocale!
      : GetStorage().read('ln') == 'ar'
          ? const Locale('ar')
          : const Locale('en');
  void changeLocal(String ln) {
    lang = ln;

    Locale locale = Locale(ln);
    Get.updateLocale(locale);
    GetStorage().write('ln', ln);
  }

  String groupValue = '';
  @override
  void onInit() {
    isDarkMode = GetStorage().read('isDarkMode') == null
        ? Get.isPlatformDarkMode
        : GetStorage().read('isDarkMode') == true
            ? true
            : false;
    signIn = GetStorage().read('signIn') ?? 0;
    super.onInit();
    lang = GetStorage().read('ln') != null
        ? (GetStorage().read('ln') == 'ar' ? 'ar' : 'en')
        : Get.deviceLocale!.languageCode == 'ar'
            ? 'ar'
            : 'en';
    groupValue = lang!;
    final savedColorValue = GetStorage().read<int>('selectedColor');

    if (savedColorValue != null) {
      selectedColor.value = Color(savedColorValue);
    }
  }
}
