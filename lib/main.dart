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
      theme: ThemeData.light(useMaterial3: false),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Login(),
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
