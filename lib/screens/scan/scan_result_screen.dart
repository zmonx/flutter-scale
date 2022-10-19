import 'package:flutter/material.dart';
import 'package:flutter_scale/themes/color.dart';
import 'package:scan/scan.dart';

class ScanResultScreen extends StatelessWidget {
  ScanController controller = ScanController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Stack(
          children: [
            ScanView(
              controller: controller,
              scanAreaScale: .8,
              scanLineColor: Color(0xFF39FF14),
              onCapture: (data) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text('scan result'),
                      ),
                      body: Column(
                        children: [
                          Center(
                            child: Text(data),
                          ),
                          Image.network(data)
                        ],
                      ),
                    );
                  },
                )).then((value) {
                  controller.resume();
                });
              },
            ),
            Positioned(
              bottom: 0,
              child: Row(
                children: [
                  ElevatedButton(
                    child: Text("toggleTorchMode"),
                    onPressed: () {
                      controller.toggleTorchMode();
                    },
                  ),
                  ElevatedButton(
                    child: Text("pause"),
                    onPressed: () {
                      controller.pause();
                    },
                  ),
                  ElevatedButton(
                    child: Text("resume"),
                    onPressed: () {
                      controller.resume();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
