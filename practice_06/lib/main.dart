import 'dart:math';
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
  int point = 0; // point
  // 랜덤 숫자를 선택했을 때 값을 받아서 화면의 point값 갱신
  void changePoint(number) {
    setState(() {
      point = number;
    });
  }

  // AlertDialog의 actions에 TextButton에 넣을 값 3개 초기화
  List<int> randomPoints = [0, 0, 0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Point : $point",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                for (int i = 0; i < 3; i++) {
                  randomPoints[i] = Random().nextInt(100); // 랜덤으로 0 ~ 99 숫자 배정
                }
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        insetPadding: const EdgeInsets.all(4.0),
                        title: const Text(
                          "Choose your next point!",
                        ),
                        // 형태에 맞게 줄 맞춤
                        content: const Text(
                          "Choose one of the points below!\nIf you don't make a selection, your current\nscore will be retained.",
                        ),
                        // changePoint : 현재 선택한 값으로 point값 변경
                        // Navigator.of(context).pop() : 현재 context, 페이지를 스택에서 제거
                        // 즉, [home, dialog] -> pop -> [home] / 그래서 dialog가 닫혀짐
                        actions: [
                          TextButton(
                            onPressed: () {
                              changePoint(randomPoints[0]);
                              Navigator.of(context).pop();
                            },
                            child: Text("${randomPoints[0]}"),
                          ),
                          TextButton(
                            onPressed: () {
                              changePoint(randomPoints[1]);
                              Navigator.of(context).pop();
                            },
                            child: Text("${randomPoints[1]}"),
                          ),
                          TextButton(
                            onPressed: () {
                              changePoint(randomPoints[2]);
                              Navigator.of(context).pop();
                            },
                            child: Text("${randomPoints[2]}"),
                          ),
                        ],
                      );
                    });
              },
              child: const Text("I want more points!"),
            )
          ],
        ),
      ),
    );
  }
}
