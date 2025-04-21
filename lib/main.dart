import 'dart:ui';

import 'utils/exporter.dart';

void main() {
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
