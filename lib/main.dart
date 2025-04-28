import 'dart:ui';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'utils/exporter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();

  Hive.init(appDocDir.path);
  Hive.registerAdapter(ReminderModelAdapter());
  await Hive.openBox<ReminderModel>('reminders');
  //initializing notifications
  NotificationService().initNotification();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: MyScroll(),
        themeMode: ThemeMode.light,
        theme: ThemeData(
            colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(0, 137, 123, 1)),
            useMaterial3: false),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: Login()
        // FilterScreen()
        //
        // SymptomCheckerPage()
        //
        // const RecordDetail()
        // OpdDetail()
        //
        // const Home()
        //
        // DoctorPage(doctor: Doctor(),)
        //
        // DepartmentPage(
        // department: Department(),
        // )

        // HospitalPage(hospital: Hospital())

        //
        );
  }
}

class MyScroll extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
