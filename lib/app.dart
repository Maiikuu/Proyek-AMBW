import 'package:flutter/material.dart';
import 'package:project/firebase/login.dart';
import 'package:project/pages/daftar_cerita.dart';
import 'package:project/pages/home.dart';
import 'package:project/pages/pengaturan.dart';
import 'package:project/pages/quiz_result.dart';
import 'package:project/pages/scan_page.dart';
import 'package:project/pages/splash_screen.dart';
import 'package:project/pages/quiz_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App>{
  
  @override
  Widget build(BuildContext context) {
    //set halaman yang sedang dibuka
    Widget screenWidget = SplashScreen();
    // Widget screenWidget = HomePage();
    // Widget screenWidget = QuizPage();
    // Widget screenWidget = CameraView();

    // Widget screenWidget = LoginPage();
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project',
      home: screenWidget,

      routes: {
        '/login': (context) => LoginPage(),
        '/splash_screen': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/scan': (context) => CameraView(),
        '/daftar_cerita': (context) => DaftarCerita(),
        '/pengaturan': (context) => Pengaturan(),
      },
    );
  }
}