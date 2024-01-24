import 'package:flutter/material.dart';

// 괴랄한 나의 코드... overflow부분 해결 못함

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: Grid()),
    );
  }
}

class Grid extends StatelessWidget {
  const Grid({super.key});

  static const int gridBorderWidth = 4;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      // 왼쪽 상단 네모
      Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: Colors.black,
            ),
            right: BorderSide(
              width: 2,
              color: Colors.black,
            ),
          ),
        ),
      ),
      // 오른쪽 상단 네모
      Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: Colors.black,
            ),
            left: BorderSide(
              width: 2,
              color: Colors.black,
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
      // 왼쪽 하단 네모
      Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 2,
              color: Colors.black,
            ),
            right: BorderSide(
              width: 2,
              color: Colors.black,
            ),
          ),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
      // 오른쪽 하단 네모
      Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 2,
              color: Colors.black,
            ),
            left: BorderSide(
              width: 2,
              color: Colors.black,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.yellow[300],
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "I can layout this",
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width /
                      2, // 기준이 될 너비 크기(디바이스의 너비의 반 - 4개)
                  childAspectRatio: 1.0,
                ),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return widgetList[index];
                },
                itemCount: 4,
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                color: Colors.yellow,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
      // body: GridView(gridDelegate: gridDelegate),
    );
  }
}
