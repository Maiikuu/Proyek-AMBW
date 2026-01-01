import 'package:flutter/material.dart';
import 'package:project/data/data_buku.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: DecoratedBox( //background image
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(URL_backgroundLogin), 
            fit: BoxFit.cover
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.15),
                child: Text(judul, style: TextStyle(fontSize: screenWidth * 0.2, letterSpacing: 5)),
                ),

              SizedBox(height: screenHeight * 0.05),
              
              Text('Login/Buat Akun Gratis', style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w700)),

              SizedBox(height: screenHeight * 0.02),

              Column( //tombol google/apple
                spacing: screenHeight * 0.02,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                  
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black, 
                      fixedSize: Size(screenWidth * 0.8, screenHeight * 0.07),
                      backgroundColor: Colors.white
                      ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: 
                            SizedBox(
                              width: screenWidth * 0.1,
                              child: Image.asset('assets/icon/google.png', fit: BoxFit.fitWidth,),
                            )
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.1),
                              child: Text('Lanjutkan dengan Google', textAlign: TextAlign.right, style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w800)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  OutlinedButton(
                    onPressed: () {},
                  
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black, 
                      fixedSize: Size(screenWidth * 0.8, screenHeight * 0.07),
                      backgroundColor: Colors.white
                      ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: 
                            Icon(Icons.apple, color: Colors.black, size: screenWidth * 0.1),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.1),
                            child: Text('Lanjutkan dengan Apple ID', textAlign: TextAlign.right, style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.37),

              SizedBox( //syarat ketentuan
                width: screenWidth,
                height: screenHeight * 0.085,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Dengan melanjutkan, Anda sudah menyetujui Syarat dan Ketentuan serta Kebijakan Privasi yang berlaku',
                    style: TextStyle(fontSize: screenHeight * 0.018, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 100, 100, 100)), textAlign: TextAlign.center),
                  )
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}