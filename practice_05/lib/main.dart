import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyList(),
    );
  }
}

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final spaceData = {
    'NGC 162': 1862,
    '87 Sylvia': 1866,
    'R 136a1': 1985,
    '28978 Ixion': 2001,
    'NGC 6715': 1778,
    '94400 Hongdaeyong': 2001,
    '6354 Vangelis': 1934,
    'C/2020 F3': 2020,
    'Cartwheel Galaxy': 1941,
    'Sculptor Dwarf Elliptical Galaxy': 1937,
    'Eight-Burst Nebula': 1835,
    'Rhea': 1672,
    'C/1702 H1': 1702,
    'Messier 5': 1702,
    'Messier 50': 1711,
    'Cassiopeia A': 1680,
    'Great Comet of 1680': 1680,
    'Butterfly Cluster': 1654,
    'Triangulum Galaxy': 1654,
    'Comet of 1729': 1729,
    'Omega Nebula': 1745,
    'Eagle Nebula': 1745,
    'Small Sagittarius Star Cloud': 1764,
    'Dumbbell Nebula': 1764,
    '54509 YORP': 2000,
    'Dia': 2000,
    '63145 Choemuseon': 2000,
  };

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<String> spaceDataKeys =
        spaceData.keys.toList(); // ListView에서 index를 갖고 있기 때문에 key값들을 List로 생성
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My First ListView!",
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        // ListView는 스크롤 위젯이며 ListView.separated : ListView.builder + 구분선
        // ListView.builder는 화면에 보여지는 리스트들을 그때마다 호출하기 위해 사용된다.
        child: ListView.separated(
            padding: const EdgeInsets.all(16.0),
            controller: controller,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                // ListTile에 모서리 쪽이 휘어진 네모난 Border를 넣는다
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.blueGrey, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                title: Text(
                  // 이모지 색상이 안나오는데 이모지 색상에 대한 용량이 크기 때문에 Web에서는 따로 설정이 필요한 것 같음
                  "🛰️ ${spaceDataKeys[index]} was discovered at ${spaceData[spaceDataKeys[index]]}",
                ),
              );
            },
            // 각 아이템 별 높이 간격
            separatorBuilder: (context, index) {
              return Container(
                height: 10,
              );
            },
            itemCount: spaceData.length),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ScrollController에서 jumpTo로 한 번에 올라갈 순 있으나 애니메이션을 아래와 같이 준다
          // offset은 0으로 주어 맨 위로 가게끔하였다
          // ease의 경우 쭈욱올라가다가 서서히 올라가는 동작
          controller.animateTo(0,
              duration: const Duration(milliseconds: 800), curve: Curves.ease);
        },
        child: const Icon(Icons.navigation),
      ),
    );
  }
}
