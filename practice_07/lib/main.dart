import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  OverlayEntry? overlayEntry;
  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  GlobalKey key3 = GlobalKey();
  GlobalKey key4 = GlobalKey();

  void createTopOverlay({required dx, required dy}) {
    // Overlay를 킬때마다 기존의 것을 삭제해준다
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;

    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: dy,
              left: dx,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      style: BorderStyle.solid,
                      width: 3.0,
                    )),
                child: const Text(
                  "You clicked this 😘",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
    Overlay.of(context).insert(overlayEntry!);
  }

  // 해당 위젯의 위치를 레이아웃에서 위치를 구한다.
  List<double> calculate(key) {
    RenderBox box =
        key.currentContext?.findRenderObject() as RenderBox; // 위젯 정보
    Offset position =
        box.localToGlobal(Offset.zero); // 현재 버튼의 위치를 좌상단(Offset.zero)을 기준으로 구한다
    double x = position.dx;
    double y = position.dy;
    return [x, y];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // body를 감싸서 버튼 이외 클릭 시 Overlay를 제거해준다
      onTap: () {
        overlayEntry?.remove();
        overlayEntry = null;
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Hello Overlay",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      key: key1,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            RenderBox box = key1.currentContext
                                ?.findRenderObject() as RenderBox;
                            List<double> coors = calculate(key1);
                            // coors : 해당 위젯의 위치(x, y)
                            // 좌상단이 기준이므로 너비만큼 더해주고, 높이만큼 빼줘서 위로 올라가게한다 - 아래 버튼들도 동일
                            createTopOverlay(
                                dx: coors[0] + box.size.width / 2,
                                dy: coors[1] - box.size.height / 2);
                          });
                        },
                        child: const Text(
                          "Hello!",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      key: key2,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            RenderBox box = key2.currentContext
                                ?.findRenderObject() as RenderBox;
                            List<double> coors = calculate(key2);
                            createTopOverlay(
                                dx: coors[0] + box.size.width / 2,
                                dy: coors[1] - box.size.height / 2);
                          });
                        },
                        child: const Text(
                          "Press",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      key: key3,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            RenderBox box = key3.currentContext
                                ?.findRenderObject() as RenderBox;
                            List<double> coors = calculate(key3);
                            createTopOverlay(
                                dx: coors[0] + box.size.width / 2,
                                dy: coors[1] - box.size.height / 2);
                          });
                        },
                        child: const Text(
                          "any!",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      key: key4,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            RenderBox box = key4.currentContext
                                ?.findRenderObject() as RenderBox;
                            List<double> coors = calculate(key4);
                            createTopOverlay(
                                dx: coors[0] + box.size.width / 2,
                                dy: coors[1] - box.size.height / 2);
                          });
                        },
                        child: const Text(
                          "Button",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
