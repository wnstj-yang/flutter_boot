import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      home: const Netflix(),
    );
  }
}

class Netflix extends StatelessWidget {
  const Netflix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Boot",
          style: GoogleFonts.singleDay(color: Colors.red),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Select a Profile to start the Flutter Boot.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Wrap(
              children: [
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue,
                              Colors.white.withOpacity(0.8),
                            ],
                          )),
                      child: CustomPaint(
                        painter: ProfileBox(),
                      ),
                    ),
                    const Text(
                      "BTS",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.yellow,
                              Colors.white.withOpacity(0.8),
                            ],
                          )),
                      child: CustomPaint(
                        painter: ProfileBox(),
                      ),
                    ),
                    const Text(
                      "BongJunHo",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Wrap(
              children: [
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.red,
                              Colors.white.withOpacity(0.8),
                            ],
                          )),
                      child: CustomPaint(
                        painter: ProfileBox(),
                      ),
                    ),
                    const Text(
                      "SonHeungMin",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.white),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "let's go",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileBox extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final eyePaint = Paint()
      ..strokeWidth = 3
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final smilePaint = Paint()
      ..strokeWidth = 4
      ..color = Colors.white
      ..style = PaintingStyle.stroke;

    // moveTo : (x, y)로 이동
    // quadraticeBezierTo(x1, y1, x2, y2) : 곡선을 만들기 위해 조절
    final Path path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.6)
      ..quadraticBezierTo(
        size.width * 0.6,
        size.height * 0.7,
        size.width * 0.8,
        size.height * 0.6,
      );

    final leftEye = Offset(size.width * 0.2, size.height / 3);
    final rightEye = Offset(size.width * 0.8, size.height / 3);
    // leftEye, rightEye로 각각 위치를 정하고, 반지름, 그릴 속성
    // drawCircle(offset, radius, paint)
    canvas.drawCircle(leftEye, 5, eyePaint);
    canvas.drawCircle(rightEye, 5, eyePaint);
    canvas.drawPath(path, smilePaint);
  }

  // 새 인스턴스가 이전 인스터와 다른 정보를 나타내는 경우 true로 해서 새로 그려야 함
  // 아닌 경우 false
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
