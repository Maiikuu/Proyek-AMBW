import 'package:flutter/material.dart';
import 'package:project/data/data_buku.dart';
import 'package:project/pages/scan_controller.dart';
import 'package:project/pages/scan_page.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:project/pages/test_firestore_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: DecoratedBox( //background image
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(URL_backgroundHome), 
            fit: BoxFit.cover
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.15),

            StrokeText(
              text: judul, 
              textStyle: TextStyle(fontSize: screenWidth * 0.25, color: Colors.black,)
                ,strokeColor: Colors.white, 
                strokeWidth: 6,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: screenHeight * 0.05),

              Column(
                spacing: screenHeight * 0.02,
                children: [
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.pushNamed(context, '/daftar_cerita')
                    },
                  
                    style: FilledButton.styleFrom(backgroundColor: Colors.white, fixedSize: Size(320, 75)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: 
                            Icon(Icons.format_list_bulleted, color: Colors.black, size: 35),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 65),
                            child: Text('Daftar Cerita', 
                              textAlign: TextAlign.right, 
                              style: TextStyle(fontSize: 22, color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.pushNamed(context, '/pengaturan')
                    },
                  
                    style: FilledButton.styleFrom(backgroundColor: Colors.white, fixedSize: Size(320, 75)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: 
                            Icon(Icons.manage_accounts, color: Colors.black, size: 35),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 65),
                            child: Text('Profile & Pengaturan', 
                              textAlign: TextAlign.right, 
                              style: TextStyle(fontSize: 22, color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () => {
                      Navigator.pushNamed(context, '/scan').then((_) {
                        ScanController controller = ScanController(context);
                        CameraView cameraView = CameraView();
                        cameraView.initialize(controller);
                      })
                    },
                  
                    style: FilledButton.styleFrom(backgroundColor: Colors.white, fixedSize: Size(320, 75)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: 
                            Icon(Icons.camera_alt_outlined, color: Colors.black, size: 35),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 65),
                            child: Text('Scan Buku', 
                              textAlign: TextAlign.right, 
                              style: TextStyle(fontSize: 22, color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TestFirestorePage()),
                      )
                    },
                  
                    style: FilledButton.styleFrom(backgroundColor: Colors.white, fixedSize: Size(320, 75)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: 
                            Icon(Icons.cloud, color: Colors.black, size: 35),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 65),
                            child: Text('Test Firestore', 
                              textAlign: TextAlign.right, 
                              style: TextStyle(fontSize: 22, color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}