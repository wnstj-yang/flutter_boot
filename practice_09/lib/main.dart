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
      debugShowCheckedModeBanner: false,
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
  // 이미지를 가져올 때의 함수이자 url 설정
  void getImages() {
    setState(() {
      String url =
          'https://picsum.photos/id/${Random().nextInt(1000) + 1}/200/200';
      imageUrls.add(url);
    });
  }

  // 초기 값을 이미지 추가 해준다
  @override
  void initState() {
    getImages();
    super.initState();
  }

  int currentIndex = 0; // 이미지 슬라이드를 하면서 현재 위치의 index
  List<String> imageUrls = []; // 이미지 리스트
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          "Click left and right",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // 왼쪽으로 갈 경우 0보다 큰 경우일 때 까지 index를 1씩 줄인다
                  if (currentIndex > 0) currentIndex -= 1;
                });
              },
              child: const Icon(Icons.arrow_left),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentIndex += 1; // 오른쪽으로 갈 경우 인덱스 증가
                  // 인덱스 증가하고 이미지를 추가해야될 때 1을 더 증가하여 이미지 목록 길이보다 크다면 추가해준다
                  // 그렇지 않으면 기존 이미지에 있는 것을 표현
                  if (currentIndex + 1 > imageUrls.length) {
                    getImages();
                  }
                });
              },
              child: const Icon(Icons.arrow_right),
            ),
          ],
        ),
        Expanded(
          child: Image.network(
            imageUrls[currentIndex],
            fit: BoxFit.cover,
            // frameBuilder는 위젯의 생성을 담당하는 빌더. frame은 로드되기 전까지 null, 끝나면 0으로 변경
            // 이외에 loadingBuilder도 있었는데 이는 이미지의 바이트 로드 과정을 알려준다
            // 예를 들어 이미지 로드 퍼센트를 구할 수 있다.
            frameBuilder: (BuildContext context, Widget child, int? frame,
                bool wasSynchronouslyLoaded) {
              if (frame != null) {
                return child;
              } else {
                return const Center(
                  child: Text(
                    'Loading...',
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text(
                  'Oops! Something went wrong',
                ),
              );
            },
          ),
        ),
      ],
    )));
  }
}
