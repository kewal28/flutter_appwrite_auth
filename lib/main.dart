import 'package:flutter/material.dart';
import 'package:flutter_appwrite_auth/Screens/landing.dart';
import 'package:flutter_appwrite_auth/app_theme.dart';
import 'package:flutter_appwrite_auth/config.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox(HiveKeys.settings),
    Hive.openBox(HiveKeys.login),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    return MaterialApp(
      theme: AppTheme.light,
   darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'Appwrite Auth',
      builder: (context, widget) {
        return MediaQuery(
          //Setting font does not change with system font size
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: widget!,
        );
      },
      home: const Landing(),
    );
  }
}
