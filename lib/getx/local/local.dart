import 'package:get/get.dart';

class MyLocal implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          'Press (add button) to add a task!.': "اضغط على (+) لإضافة مهمة!",
          //SplashScreen
          'dev':
              "تم التطوير بواسطة نجيد عبدالله عيسى\nجميع الحقوق محفوظة © 2025",
          //Home Screen
          "Incomplete Tasks!": "المهام غير المكتملة!",
          "Non-repeating incomplete tasks have been moved to the archive list.":
              "تم نقل المهام غير المكتملة وغير القابلة للتكرار إلى قائمة الأرشيف",
          'deleting task': 'حذف المهمة...',
          'my tasks': 'مهامي',
          //!Sorting prop
          'show menu': 'إظهار القائمة',
          'sort': 'الترتيب حسب',
          'time': 'الوقت',
          'title': 'العنوان',
          'default': "الترتيب الافتراضي",
          //! menu button
          'not finish': 'المهام المؤرشفة',
          'settings button': 'الإعدادات',
          'about button': 'التفاصيل',
          'delete tasks': 'حذف جميع المهام',
          'dialog delete warning': 'حذف جميع المهام؟',
          'dialog subTitle':
              "هل أنت متأكد أنك تريد حذف جميع المهام؟ لا يمكن التراجع عن هذا الإجراء.",
          'dialog d button': 'حذف',
          'dialog c button': "إلغاء",
          //!Search Text Field
          'hint text field': 'ابحث عن مهمة...',
          //! No tasks in home screen
          'done all tasks': "لقد أنجزت جميع المهام!🔥",
          'no task found': "لم يتم العثور على أي مهمة",
          'no task found subTitle':
              "حاول البحث بمصطلح مختلف أو تحقق من تهجئتك.",
          // Add and Update Screen
          'Repet': 'مهمة متكررة',
          "Priority": 'الأهمية',
          "Low": 'غير مهمة',
          'Midum': 'مهمة عادية',
          'High': 'مهمة',
          'Select Time': 'حدد الوقت',
          'Select Date': 'حدد التاريخ',
          'date': "التاريخ",
          'add screen title': 'إضافة مهمة',
          'update screen title': "تعديل المهمة",
          'task title': 'عنوان المهمة',
          'task subTitle': 'ما الذي يدور في ذهنك اليوم؟ 😊',
          'Missing Fields': 'حقول مفقودة',
          "Please fill in all the fields": 'يرجى تعبئة جميع الحقول',
          //Setting Screen
          'App Version: v1.0.0': 'إصدار التطبيق: v1.0.0',
          'setting title': 'الإعدادات',
          'theme': 'المظهر',
          'Dark Mode': 'الوضع الداكن',
          'Display Color': 'الوان الشاشة',
          'Text': 'النص',
          'Language': "اللغة",
          'Arabic': 'العربية',
          'English': 'الإنجليزية',
          'Font Style': 'نوع الخط',
          'System': 'النظام',
          'Notifications': 'الإشعارات',
          'Application': 'التطبيق',
          "Rate the app on the store": 'قيّم التطبيق على المتجر',
          'Share Application': "مشاركة التطبيق",
          'Delete Data': "حذف البيانات",
          "Select a Color": 'اختيار لون',
          'Ok': 'موافق',
          //DetailsScreen
          '1':
              'تطبيق لإدارة المهام اليومية بسهولة, حيث يتمتع بواجهة مستخدم عصرية',
          '2': "الميزات الرئيسية:",
          '3': "إدارة المهام بسهولة",
          '4': 'تصميم عصري',
          '5': 'دعم الوضع الداكن',
          '6': 'تذكيرات للبقاء منظمًا',
          '7': 'الأسئلة الشائعة:',
          'q1': 'كيف يمكنني إضافة مهمة جديدة؟',
          'a1':
              'يمكنك إضافة مهمة من خلال الضغط على زر الإضافة في الشاشة الرئيسية.',
          'q2': 'هل يدعم التطبيق الوضع الداكن؟',
          'a2':
              'نعم، يمكنك التبديل بين الوضعين الداكن والفاتح من خلال الإعدادات.',
          'q3': 'كيف يمكنني تعديل مهمتي؟',
          'a3':
              'لتعديل مهمتك، ما عليك سوى الضغط مع الاستمرار على المهمة أو النقر على أي مكان في النص للدخول إلى وضع التحرير.',
          //Archive Screen
          'nothing': "لا يوجد مهام غير مكتملة",
          //TutrialScreen
          'Get Started': "ابدأ",
          'skip': 'تخطي',
          'Welcome to Taskly':
              'مرحبًا بك في Taskly،\nحيث تلتقي الإنتاجية مع البساطة!',

          'page2':
              "هنا، يمكنك إضافة مهامك\nوتنظيم يومك بسهولة. دعنا نساعدك في إنجاز كل شيء!",

          'page3':
              "هل أنت جاهز للبدء؟\nمع Taskly، كل مهمة ستكون أقرب لتحقيقها. لنبدأ!",
        },
        'en': {
          "Incomplete Tasks!": "Incomplete Tasks!",
          "Non-repeating incomplete tasks have been moved to the archive list.":
              "Non-repeating incomplete tasks have been moved to the archive list.",
          'Press (add button) to add a task!.': 'Press (+) to add a task!.',
          //!
          'dev':
              'Developed by Nojaid Abdullah Issa\nAll rights reserved © 2025',
          //!
          'deleting task': 'Deleting Task...',
          'my tasks': 'My Tasks',
          //!
          'show menu': 'Show Menu',
          'sort': 'Sort By',
          'time': 'Time',
          'title': 'Title',
          'default': 'Default',
          //! menu button
          'not finish': 'Archive Tasks',
          'settings button': 'Settings',
          'about button': 'Details',
          'delete tasks': 'Delete Tasks',
          'dialog delete warning': 'Delete All Tasks?',
          'dialog subTitle':
              'Are you sure you want to delete all tasks? This action cannot be undone.',
          'dialog d button': 'Delete',
          'dialog c button': 'Cancel',
          'hint text field': 'Find a task...',
          //! No tasks in home screen
          'done all tasks': 'You Have Done All Tasks!🔥',
          'no task found': "No task found",
          'no task found subTitle':
              'Try searching with a different term or check your spelling.',
          // Add and Update Screen
          'Repet': 'Repeated Task',
          "Priority": 'Priority',
          "Low": 'Low',
          'Midum': 'Normal',
          'High': 'High',
          'Select Time': 'Select Time',
          'Select Date': 'Select Date',
          'date': 'Date',
          'add screen title': 'Add New Task',
          'update screen title': "Edit Task",
          'task title': 'Task Title',
          'task subTitle': "What's on your mind today? 😊",
          'Missing Fields': 'Missing Fields',
          "Please fill in all the fields": "Please fill in all the fields.",
          //Setting Screen
          'App Version: v1.0.0': 'App Version: v1.0.0',
          'setting title': 'Settings',
          'theme': 'Theme',
          'Dark Mode': 'Dark Mode',
          'Display Color': 'Display Color',
          'Text': 'Text',
          'Language': 'Language', 'Arabic': 'Arabic',
          'English': 'English',
          'Font Style': 'Font Style',
          'System': 'System',
          'Notifications': 'Notifications',
          "مشاركة التطبيق"
              'Application': 'Application',
          "Rate the app on the store": "Rate the app on the store",
          'Share Application': 'Share Application',
          'Delete Data': 'Delete Data',
          "Select a Color": "Select a Color",
          'Ok': 'Ok',
          //DetailsScreen
          '1':
              "An advanced app for effortless daily task management, featuring a modern and user-friendly interface.",
          "2": 'Key Features:',
          "3": 'Easy task management',
          '4': 'Modern design',
          '5': 'Dark mode support',
          '6': 'Reminders to stay organized',
          '7': 'FAQs:',
          'q1': 'How do I add a new task?',
          'a1':
              "You can add a task by clicking the add button on the home screen.",
          'q2': "Does the app support dark mode?",
          'a2':
              "Yes, you can toggle between dark and light modes in the settings.",
          'q3': 'How can i edit my task?',
          'a3':
              'To edit your task, simply long-press on the task or tap anywhere on the text to enter the editing mode.',
          //Archive Screen
          'nothing': "There is no expired tasks",
          //TutrialScreen
          'Get Started': "Get Started",
          'skip': 'Skip',
          'Welcome to Taskly':
              'Welcome to Taskly,\nwhere productivity meets simplicity!',

          'page2':
              "Here, you can easily add your tasks\nand organize your day. Let us help you get things done!",

          'page3':
              "Are you ready to get started?\nWith Taskly, every task is closer to completion. Let's begin!",
        },
      };
}
