import 'package:flutter/material.dart';
import 'package:project/data/data_buku.dart';
import 'package:project/pages/Cerita/halaman_utama_cerita/cerita.dart';

class DaftarCerita extends StatefulWidget {
  const DaftarCerita({super.key});

  @override
  State<DaftarCerita> createState() => _DaftarCeritaState();
}

class _DaftarCeritaState extends State<DaftarCerita> {
  @override
  Widget build(BuildContext context) {
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(
          style: ButtonStyle(
            iconSize: MaterialStateProperty.all(35),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: DecoratedBox( //background image
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(URL_BackgroundDaftarCerita), 
            fit: BoxFit.cover
          ),
        ),
        //Content
        child: SingleChildScrollView(
            child: Column(
            children: [
              SizedBox(height: screenHeight * 0.15),

              Align(
                alignment: Alignment.center,
                child: Text('Daftar Cerita', style: TextStyle(fontSize: screenWidth * 0.1, letterSpacing: (screenWidth * 0.1) * 0.1)),
              ),

              SizedBox(height: screenHeight * 0.03),
              Column(
                //Daftar Cerita
                children: [
                  for (int i = 0; i < HALAMAN.length; i++) ...[
                    //Halaman: [judul, imageURL], AYAT: [Ayat, isiAyat]
                    CeritaWidget(screenWidth, screenHeight, HALAMAN[i][0], HALAMAN[i][1], AYAT[i][0], AYAT[i][1], i),
                    SizedBox(height: screenHeight * 0.02),
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton CeritaWidget(var screenWidth, var screenHeight, String judul, String imageURL, String judulAyat, String isiAyat, int index) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,  
        fixedSize: Size(screenWidth * 0.85, screenHeight * 0.12), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      onPressed: () => {
        Navigator.push (
          context, 
          MaterialPageRoute(builder: (context) => Cerita(judul_halaman: judul, ayat: judulAyat, isi_ayat: isiAyat, url_gambar: imageURL, index: index))),
      },
      child: Row(
        children: [
          Image.asset(imageURL, width: screenWidth * 0.18, height: screenWidth * 0.18),
          SizedBox(width: screenWidth * 0.02), 
          Expanded( 
            child: Text(
              judul,
              style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.black),
              softWrap: true, 
              overflow: TextOverflow.visible, 
            ),
          ),
        ],
      ),
    );
  }
}