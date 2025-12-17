import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/data/data_buku.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> { 
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(URL_SplashScreen), 
              fit: BoxFit.cover
            ),
          ),
          child: Center()
          ),
        ),
      );
  }

  @override 
  void initState() { 
    super.initState(); 
  
    Timer( 
      Duration(seconds: 3), 
      //TODO
      () => Navigator.pushNamed(context, '/login')
    ); 
  } 
}