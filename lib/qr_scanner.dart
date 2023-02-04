// import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcodeapp/qr_overlay.dart';
import 'package:qrcodeapp/result_screen.dart';
// import 'package:qr_scanner/qr_scanner_web.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller = MobileScannerController();
  void closeScanner() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Neumorphic(
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          // color: const Color(0xFFF3F6FD),
                          color: Colors.black,
                          intensity: 1,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'ORCSAG',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                letterSpacing: 1.5,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFlashOn = !isFlashOn;
                          });
                          controller.toggleTorch();
                        },
                        child: Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(12)),
                              color: isFlashOn
                                  ? const Color(0xFFF3F6FD)
                                  : Colors.black,
                              intensity: 1),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(Icons.flash_on,
                                color: isFlashOn
                                    ? Colors.black
                                    : const Color(0xFFF3F6FD)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isFrontCamera = !isFrontCamera;
                            });
                            controller.switchCamera();
                          },
                          child: Neumorphic(
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(12)),
                                color: isFrontCamera
                                    ? const Color(0xFFF3F6FD)
                                    : Colors.black,
                                intensity: 1),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(Icons.camera_front_outlined,
                                  color: isFrontCamera
                                      ? Colors.black
                                      : const Color(0xFFF3F6FD)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12)),
                      color: const Color(0xFFF3F6FD),
                      intensity: 1,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Place the Scanner above the QR Code",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                ],
              )),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 4,
                child: Stack(
                  // alignment: FractionalOffset.center,
                  // fit: StackFit.expand,
                  children: [
                    MobileScanner(
                      controller: controller,
                      allowDuplicates: true,
                      onDetect: (barcode, args) {
                        if (!isScanCompleted) {
                          String bCode = barcode.rawValue ?? '---';
                          isScanCompleted = true;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                        closeScreen: closeScanner,
                                        code: bCode,
                                      )));
                        }
                      },
                    ),
                    // Container(width:300.0,height:300.0,decoration: const BoxDecoration(color: Colors.white),),
                    // Container(width:300.0,height:300.0,decoration: const BoxDecoration(color: Colors.black),),
                    QRScannerOverlay(
                        overlayColour: Colors.black.withOpacity(0.5)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    color: const Color(0xFFF3F6FD),
                    intensity: 1,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Scans once the scanner is placed",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Developed By AVJ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}
