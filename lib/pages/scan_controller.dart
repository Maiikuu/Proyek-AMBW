import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/data/data_buku.dart';
import 'package:project/pages/Cerita/halaman_utama_cerita/cerita.dart';

class ScanController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    cameraCount = 0;
    initCamera();
    initTflite();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  initialize() {
    cameraCount = 0;
    initCamera();
    initTflite();
  }
  
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  var cameraCount;
  var detector;

  var isCameraInitialized = false.obs;
  bool pageDetected = false;

  BuildContext context;

  ScanController(this.context);

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      
      cameraController = await CameraController(
        cameras[0], 
        ResolutionPreset.medium
        );
      await cameraController.initialize().then((value) {
        cameraController.startImageStream((image) {
          cameraCount++;
          if (cameraCount %10 == 0) {
            cameraCount = 0;
            objectDetector(image);
          }
          update();
        });
      });
      isCameraInitialized(true);
      update();
      } 
      else {
        print('Camera permission denied');
    }
  }

  initTflite() async {
    await Tflite.loadModel(
      model: "assets/tensorFlow/model_unquant.tflite",
      labels: "assets/tensorFlow/labels.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
      );
  }

  objectDetector(CameraImage image) async {
    detector = await Tflite.runModelOnFrame(bytesList: image.planes.map((e) {
      return e.bytes; 
    }).toList(),
    asynch: true,
    imageHeight: image.height,
    imageWidth: image.width,
    imageMean: 127.5,
    imageStd: 127.5,
    numResults: 1,
    rotation: 90,
    threshold: 0.4,
    );

    if (detector != null ) {
      if (detector.isNotEmpty && detector[0]['confidence'] >= 0.90 && cameraController.value.isStreamingImages) {
        // ==========================================================
        // ===== BAGIAN YANG DIGANTI DIMULAI DARI SINI ================
        // ==========================================================
        switch(detector[0]['label']) {
          case '0 Perbudakan Mesir - 1':
          case '1 Perbudakan Mesir - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[0][0], ayat: AYAT[0][0], isi_ayat: AYAT[0][1], url_gambar: HALAMAN[0][1], index: 0)));
              await cameraController.stopImageStream();
              detector = null;
            break;
          case '2 Perintah Raja':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[1][0], ayat: AYAT[1][0], isi_ayat: AYAT[1][1], url_gambar: HALAMAN[1][1], index: 1)));
              await cameraController.stopImageStream();
            break;
          case '3 Musa Lahir - 1':
          case '4 Musa Lahir - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[2][0], ayat: AYAT[2][0], isi_ayat: AYAT[2][1], url_gambar: HALAMAN[2][1], index: 2)));
            break;
          case '5 Musa Lahir - 1':
          case '6 Musa Lahir - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[3][0], ayat: AYAT[3][0], isi_ayat: AYAT[3][1], url_gambar: HALAMAN[3][1], index: 3)));
            break;
          case '7 Diselamatkan Putri Raja - 1':
          case '8 Diselamatkan Putri Raja - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[4][0], ayat: AYAT[4][0], isi_ayat: AYAT[4][1], url_gambar: HALAMAN[4][1], index: 4)));
            break;
          case '9 Musa Membela Budak Ibrani - 1':
          case '10 Musa Membela Budak Ibrani - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[5][0], ayat: AYAT[5][0], isi_ayat: AYAT[5][1], url_gambar: HALAMAN[5][1], index: 5)));
            break;
          case '11 Yitro Menyambut Musa - 1':
          case '12 Yitro Menyambut Musa - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[6][0], ayat: AYAT[6][0], isi_ayat: AYAT[6][1], url_gambar: HALAMAN[6][1], index: 6)));
            break;
          case '13 Semak yang Menyala - 1':
          case '14 Semak yang Menyala - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[7][0], ayat: AYAT[7][0], isi_ayat: AYAT[7][1], url_gambar: HALAMAN[7][1], index: 7)));
            break;
          case '15 Musa Membuat Mukjizat - 1':
          case '16 Musa Membuat Mukjizat - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[8][0], ayat: AYAT[8][0], isi_ayat: AYAT[8][1], url_gambar: HALAMAN[8][1], index: 8)));
            break;
          case '17 Harun dan Musa - 1':
          case '18 Harun dan Musa - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[9][0], ayat: AYAT[9][0], isi_ayat: AYAT[9][1], url_gambar: HALAMAN[9][1], index: 9)));
            break;
          case '19 Biarkanlah Umat-Ku Pergi - 1':
          case '20 Biarkanlah Umat-Ku Pergi - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[10][0], ayat: AYAT[10][0], isi_ayat: AYAT[10][1], url_gambar: HALAMAN[10][1], index: 10)));
            break;
          case '21 Darah dan Katak - 1':
          case '22 Darah dan Katak - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[11][0], ayat: AYAT[11][0], isi_ayat: AYAT[11][1], url_gambar: HALAMAN[11][1], index: 11)));
            break;
          case '23 Nyamuk dan Lalat - 1':
          case '24 Nyamuk dan Lalat - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[12][0], ayat: AYAT[12][0], isi_ayat: AYAT[12][1], url_gambar: HALAMAN[12][1], index: 12)));
            break;
          case '25 Penyakit dan Bisul - 1':
          case '26 Penyakit dan Bisul - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[13][0], ayat: AYAT[13][0], isi_ayat: AYAT[13][1], url_gambar: HALAMAN[13][1], index: 13)));
            break;
          case '27 Hujan Es dan Belalang - 1':
          case '28 Hujan Es dan Belalang - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[14][0], ayat: AYAT[14][0], isi_ayat: AYAT[14][1], url_gambar: HALAMAN[14][1], index: 14)));
            break;
          case '29 Kegelapan dan Kematian - 1':
          case '30 Kegelapan dan Kematian - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[15][0], ayat: AYAT[15][0], isi_ayat: AYAT[15][1], url_gambar: HALAMAN[15][1], index: 15)));
            break;
          case '31 Tuhan Menepati Janji-Nya - 1':
          case '32 Tuhan Menepati Janji-Nya - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[16][0], ayat: AYAT[16][0], isi_ayat: AYAT[16][1], url_gambar: HALAMAN[16][1], index: 16)));
            break;
          case '33 Orang Israel Keluar dari Mesir - 1':
          case '34 Orang Israel Keluar dari Mesir - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[17][0], ayat: AYAT[17][0], isi_ayat: AYAT[17][1], url_gambar: HALAMAN[17][1], index: 17)));
            break;
          case '35 Dikejar Tentara Mesir - 1':
          case '36 Dikejar Tentara Mesir - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[18][0], ayat: AYAT[18][0], isi_ayat: AYAT[18][1], url_gambar: HALAMAN[18][1], index: 18)));
            break;
          case '37 Laut Merah Dibelah - 1':
          case '38 Laut Merah Dibelah - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[19][0], ayat: AYAT[19][0], isi_ayat: AYAT[19][1], url_gambar: HALAMAN[19][1], index: 19)));
            break;
          case '39 Air bagi yang Haus - 1':
          case '40 Air bagi yang Haus - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[20][0], ayat: AYAT[20][0], isi_ayat: AYAT[20][1], url_gambar: HALAMAN[20][1], index: 20)));
            break;
          case '41 Makanan bagi yang Lapar - 1':
          case '42 Makanan bagi yang Lapar - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[21][0], ayat: AYAT[21][0], isi_ayat: AYAT[21][1], url_gambar: HALAMAN[21][1], index: 21)));
            break;
          case '43 Umat Meragukan Tuhan - 1':
          case '44 Umat Meragukan Tuhan - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[22][0], ayat: AYAT[22][0], isi_ayat: AYAT[22][1], url_gambar: HALAMAN[22][1], index: 22)));
            break;
          case '45 Di Kaki Gunung Sinai - 1':
          case '46 Di Kaki Gunung Sinai - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[23][0], ayat: AYAT[23][0], isi_ayat: AYAT[23][1], url_gambar: HALAMAN[23][1], index: 23)));
            break;
          case '47 Sepuluh Firman - 1':
          case '48 Sepuluh Firman - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[24][0], ayat: AYAT[24][0], isi_ayat: AYAT[24][1], url_gambar: HALAMAN[24][1], index: 24)));
            break;
          case '49 Janji Tuhan bagi Israel - 1':
          case '50 Janji Tuhan bagi Israel - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[25][0], ayat: AYAT[25][0], isi_ayat: AYAT[25][1], url_gambar: HALAMAN[25][1], index: 25)));
            break;
          case '51 Umat Mau Menaati Tuhan - 1':
          case '52 Umat Mau Menaati Tuhan - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[26][0], ayat: AYAT[26][0], isi_ayat: AYAT[26][1], url_gambar: HALAMAN[26][1], index: 26)));
            break;
          case '53 Lembu Emas - 1':
          case '54 Lembu Emas - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[27][0], ayat: AYAT[27][0], isi_ayat: AYAT[27][1], url_gambar: HALAMAN[27][1], index: 27)));
            break;
          case '55 Musa Menghancurkan Berhala - 1':
          case '56 Musa Menghancurkan Berhala - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[28][0], ayat: AYAT[28][0], isi_ayat: AYAT[28][1], url_gambar: HALAMAN[28][1], index: 28)));
            break;
          case '57 Tuhan Berbelas Kasih - 1':
          case '58 Tuhan Berbelas Kasih - 2':
            pageDetected = true;
            Navigator.push (
              context, 
              MaterialPageRoute(builder: (context) => Cerita(judul_halaman: HALAMAN[29][0], ayat: AYAT[29][0], isi_ayat: AYAT[29][1], url_gambar: HALAMAN[29][1], index: 29)));
            break;
        }
      }
    }
  }
}