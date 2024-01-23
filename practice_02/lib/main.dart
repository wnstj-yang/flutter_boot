import 'package:flutter/material.dart';

// 레이아웃은 잡았어도 animation 부분을 몰라서 다른 분 꺼 참고하여 의미 파악 위주로 진행...ㅠㅠ

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GaugeBar(),
    );
  }
}

class GaugeBar extends StatefulWidget {
  const GaugeBar({super.key});

  @override
  State<GaugeBar> createState() => _GaugeBarState();
}

class _GaugeBarState extends State<GaugeBar>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;
  int score = 0;
  double gaugeHeight = 0.0;
  double stdHeight = 400.0;
  double step = 100.0;

  void increaseGauge() {
    setState(() {
      // 흠... 기준 높이에 맞게 설정하면 애니메이션으로 올라가도 끝까지 안닿아서 1.03을 곱해 크기에 맞춰 주도록 함.
      gaugeHeight = (gaugeHeight + step)
          .clamp(0.0, stdHeight * 1.03); // clamp 범위를 지정해주기 위함
      if (gaugeHeight >= stdHeight) {
        score += 1;
      }
    });
    // animation - 게이지를 내려오게 만든다.
    animation = Tween<double>(begin: gaugeHeight, end: 0.0).animate(
      CurvedAnimation(parent: controller!, curve: Curves.easeOut),
    );

    controller!.forward(from: 0.0); // 애니메이션 실행
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1700), // 애니메이션 지속 시간
      vsync: this,
    );

    animation = Tween<double>(begin: 0.0, end: 0.0).animate(controller!)
      ..addListener(() {
        // 값이 변경될 때마다 - animation진행될 때마다 높이 변경
        setState(() {
          gaugeHeight = animation!.value;
        });
      })
      ..addStatusListener((status) {
        // animation이 변경될 때마다 - 아래의 경우 애니메이션이 끝날 때 score 0으로 초기화
        if (status == AnimationStatus.completed) {
          setState(() {
            score = 0;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Your Score",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "$score",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Positioned(
                  child: Container(
                    width: 50,
                    height: stdHeight,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  child: AnimatedContainer(
                    width: 50,
                    height: gaugeHeight,
                    duration: const Duration(
                      milliseconds: 50,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              increaseGauge();
            },
            child: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
    );
  }
}
