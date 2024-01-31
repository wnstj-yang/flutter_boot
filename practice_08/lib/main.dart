import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  late String name;
  late String height;
  late String mass;
  late String hairColor;
  late String skinColor;

  User({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
  });

  // json파일 형태를 json 자료형으로 변환 이후 객체로 만들기 위해 사용
  User.fromJson(Map data) {
    name = data['name'];
    height = data['height'];
    mass = data['mass'];
    hairColor = data['hair_color'];
    skinColor = data['skin_color'];
  }
}

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
  TextEditingController textController = TextEditingController();
  String status = ''; // 상태
  List<User> users = []; // users
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 다른 부분에 탭 할 시 unfocus하여 키보드를 내린다
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 25),
                          ),
                          onPressed: () async {
                            var url = Uri.https("swapi.dev", "/api/people",
                                {'search': textController.value.text});
                            // state가 바뀌긴 해서 setState를 사용하지만, 위젯을 리로딩하기 때문에... 어느정도 지양해야 하지만 사용..
                            setState(() {
                              status = "loading";
                            });
                            http.Response response =
                                await http.get(url); // 응답받을 때 까지 기달
                            var responseBody =
                                jsonDecode(response.body); // json 문자열로 파싱
                            // 값이 0이면 status 변경과 함께 users목록을 초기화
                            if (responseBody['results'].length == 0) {
                              status = 'empty';
                              users = [];
                              // 응답으로 받은 사람들에 대해 User객체로 만들어서 한명 씩 추가
                            } else {
                              for (int i = 0;
                                  i < responseBody['results'].length;
                                  i++) {
                                users.add(
                                    User.fromJson(responseBody['results'][i]));
                              }
                              status = 'show'; // 보여준다
                            }
                            // 마지막 setState변화가 감지됨을 표현하며 리로딩
                            setState(() {});
                          },
                          child: const Text(
                            "Search!",
                          ),
                        ),
                      ),
                      hintText: 'Enter the name of a Star Wars...'),
                ),
              ),
              Expanded(
                child: Center(child: (() {
                  switch (status) {
                    case 'empty':
                      return const Text(
                        "No results found, please try again with a different search term!",
                      );
                    case 'loading':
                      return const Text(
                        "Loading...",
                      );
                    case 'show':
                      return ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        users[index].name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                      Text(
                                        "${users[index].height} / ${users[index].mass}",
                                      ),
                                      Text(
                                        "Hair Color : ${users[index].hairColor} | Skin Color : ${users[index].skinColor}",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    default:
                      return null;
                  }
                })()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
