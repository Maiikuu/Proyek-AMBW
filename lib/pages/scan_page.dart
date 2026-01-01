import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:project/pages/scan_controller.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          style: ButtonStyle(
            iconSize: WidgetStateProperty.all(35),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: GetBuilder<ScanController>(
        init: ScanController(context),
        builder: (controller) {
          return Center(
            child: controller.isCameraInitialized.value ? 
            CameraPreview(controller.cameraController) : 
            Text(
              'Loading camera...',
              style: TextStyle(fontSize: screenWidth * 0.1, color: Colors.black,),
            ),
          );
        }
      ),
    );
  }
  void initialize(ScanController controller) async {
    await controller.initialize();
  }
}